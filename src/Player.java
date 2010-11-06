/*
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send
 * a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco,
 * California, 94105, USA.
 */

public class Player {

    public final eo player_obj;

    public Player(eo player_obj) {
        this.player_obj = player_obj;
    }

    @Override
    public String toString() {
        return GetName();
    }

    public String GetName() {
        return player_obj.ar;
    }

    public void Kick(String msg) {
        player_obj.a.c(msg);
    }

    public void SendMessage(String msg) {
        player_obj.a.b(msg);
    }
}
