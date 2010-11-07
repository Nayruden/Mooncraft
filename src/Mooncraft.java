/*
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send
 * a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco,
 * California, 94105, USA.
 */

import java.io.File;
import java.io.FilenameFilter;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.minecraft.server.MinecraftServer;
import org.keplerproject.luajava.*;

public class Mooncraft {

    public static String logger_name = "Minecraft";
    public static LuaState L;
    static LuaObject LCallHook;

    public static enum Callback {

        PlayerConnect("OnPlayerConnect"),
        PlayerDisconnect("OnPlayerDisconnect"),
        PlayerChat("OnPlayerChat"),
        ServerCommand("OnServerCommand"),
        ClientCommand("OnClientCommand"),
        Init("OnInit");
        protected String callback_name;

        private Callback(String callback_name) {
            this.callback_name = callback_name;
        }

        public Object call(Object... arguments) {
            Object[] newargs = new Object[arguments.length + 1];
            newargs[0] = callback_name;
            System.arraycopy(arguments, 0, newargs, 1, arguments.length);
            return Call(LCallHook, newargs);
        }
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        if (!new File("minecraft_server.jar").exists()) {
            System.err.println("FATAL: Minecraft server jar was not found");
            return;
        }

        L = LuaStateFactory.newLuaState();
        L.openLibs();

        if (!new File("lua/includes/preinit.lua").isFile()) {
            System.err.println("FATAL: Could not find lua/includes/preinit.lua");
            return;
        }
        DoFile("lua/includes/preinit.lua");
        LuaObject hooks = L.getLuaObject("hooks");

        LuaObject LRegisterHook;
        try {
            LCallHook = hooks.getField("Call");
            LRegisterHook = hooks.getField("RegisterHookName");
        } catch (LuaException ex) {
            System.err.println("FATAL: Hook library not setup up correctly");
            return;
        }

        for (Callback callback : Callback.values()) {
            Call(LRegisterHook, callback.callback_name);
        }

        DoFile("lua/includes/init.lua");

        File autorun_dir = new File("lua/autorun");
        if (!autorun_dir.isDirectory()) {
            System.err.println("FATAL: lua/autorun is not a directory");
        }

        String[] lua_files = autorun_dir.list(new FilenameFilter() {

            public boolean accept(File dir, String name) {
                return name.endsWith(".lua");
            }
        });

        for (String file : lua_files) {
            DoFile("lua/autorun/" + file);
        }        

        MooncraftServer.main(args); // This will loop until server end
    }

    private static void DoFile(String file) {
        int res = L.LdoFile(file);
        if (res != 0) {
            System.out.println(L.toString(-1));
        }
    }

    public static Object Call(LuaObject fn, Object... arguments) {
        Object obj = null;
        try {
            obj = fn.call(arguments);
        } catch (LuaException ex) {
            System.err.println(ex);
        } finally {
            return obj;
        }
    }
}
