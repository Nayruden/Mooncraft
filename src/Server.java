/*
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send
 * a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco,
 * California, 94105, USA.
 */

import java.util.logging.Logger;
import net.minecraft.server.MinecraftServer;

public class Server {

    static MinecraftServer server;
    static String MinecraftServerVersion;
    static final String CompiledAgainstVersion = "0.2.4";
    private static final Logger logger = Logger.getLogger(Mooncraft.logger_name);

    public static void LogInfo(String msg) {
        logger.info(msg);
    }

    public static void LogWarning(String msg) {
        logger.warning(msg);
    }

    public static void LogSevere(String msg) {
        logger.severe(msg);
    }

    public static void BroadcastMessageToOps(String msg) {
        server.f.i(msg);
    }

    public static void BroadcastMessage(String msg) {
        server.f.a(new bg(msg));
    }
}
