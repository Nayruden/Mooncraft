/*
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send
 * a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco,
 * California, 94105, USA.
 */

import java.awt.GraphicsEnvironment;
import java.util.logging.Level;
import net.minecraft.server.MinecraftServer;

public class MooncraftServer extends MinecraftServer {

    @Override
    // This function seems to be called to INSERT commands to be processed.
    // We're probably pre-empting something here, but tests indicate it works okay.
    public void a(String paramString, eu parameu) {
        ICommandIssuer command_issuer;
        if (parameu.c().equals("CONSOLE")) {
            command_issuer = Console.GetInstance();
        } else {
            command_issuer = PlayerManager.GetByName(parameu.c());
        }
        Object res = Mooncraft.Callback.ServerCommand.call(command_issuer, paramString);
        if (res != null) {
            return;
        }

        super.a(paramString, parameu);
    }

    public static void main(String[] paramArrayOfString) {
        try {
            MinecraftServer localMinecraftServer = new MooncraftServer();
            Server.server = localMinecraftServer;

            if ((!GraphicsEnvironment.isHeadless()) && ((paramArrayOfString.length <= 0) || (!paramArrayOfString[0].equals("nogui")))) {
                gi.a(localMinecraftServer);
            }

            new bw("Server thread", localMinecraftServer).start();
        } catch (Exception localException) {
            a.log(Level.SEVERE, "Failed to start the minecraft server", localException);
        }
    }
}
