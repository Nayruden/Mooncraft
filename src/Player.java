/*
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send
 * a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco,
 * California, 94105, USA.
 */

import java.util.Calendar;
import java.util.logging.Logger;

public class Player implements ICommandIssuer {

    private static final Logger logger = Logger.getLogger(Mooncraft.logger_name);
    public final eo player_obj;

    private final long joined;

    public Player(eo player_obj) {
        this.player_obj = player_obj;
        joined = Calendar.getInstance().getTimeInMillis();
    }

    @Override
    public String toString() {
        return GetName();
    }

    public String GetName() {
        return player_obj.ar;
    }

    public long GetTimeJoined() {
        return joined;
    }

    public void Kick(String msg) {
        logger.info("Kicking " + GetName() + " (" + msg + ")");
        player_obj.a.c(msg);
    }

    public void SendMessage(String msg) {
        player_obj.a.b(msg);
    }

    public boolean IsConsole() {
        return false;
    }

    public boolean IsOp() {
        return Server.server.f.g(GetName());
    }
}
