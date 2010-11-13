/*
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send
 * a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco,
 * California, 94105, USA.
 */

import java.util.Calendar;
import java.util.logging.Logger;
import org.keplerproject.luajava.LuaException;

public class Player implements ICommandIssuer {
    /*
     * Notes:
     *  player_obj.c.a.ak.a is the bottom four rows of inventory (0-35)
     *  player_obj.c.a.ak.b is the armor slots (100-103)
     *  player_obj.c.a.ak.c is the crafting slots (80-83)
     */

    private static final Logger logger = Logger.getLogger(Mooncraft.logger_name);
    public final ep player_obj;
    private final long joined;

    public Player(ep player_obj) {
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

    public void UpdateInventory() {
        player_obj.a.d();
    }

    public void SetInventory(int slot, int id, int amount) throws LuaException {
        if (slot >= 0 && slot < 36) {
            player_obj.c.a.ak.a[slot] = (id == 0 ? null : new hj(id, amount));
        } else if (slot >= 100 && slot < 104) {
            if (id < 298 || id > 317 || (id - 298) % 4 != (103 - slot)) {
                throw new LuaException("invalid item id for slot");
            }
            player_obj.c.a.ak.b[slot - 100] = (id == 0 ? null : new hj(id, 1));
        } else if (slot >= 80 && slot < 84) {
            player_obj.c.a.ak.c[slot - 80] = (id == 0 ? null : new hj(id, amount));
        } else {
            // TODO: Error
        }

        // Doesn't show up for players without this call
        UpdateInventory();
    }
}
