
import java.util.logging.Logger;
import net.minecraft.server.MinecraftServer;

/*
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send
 * a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco,
 * California, 94105, USA.
 */
public class Server {

    static MinecraftServer server;
    private static Logger logger = Logger.getLogger(Mooncraft.logger_name);

    public static void BroadcastMessage(String msg) {
        server.f.i(msg);
    }
}
