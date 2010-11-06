/*
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send
 * a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco,
 * California, 94105, USA.
 */

import java.util.*;

public class PlayerManager {
    private static Map<String, Player> players = new TreeMap<String, Player>();

    static Player AddPlayer(eo player_obj) {
        Player player = new Player(player_obj);
        players.put(player_obj.ar, player);
        return player;
    }

    public static Player GetByName(String name) {
        return players.get(name);
    }

    public static Player[] GetAll() {
        Player players_arr[] = new Player[ players.size() ];
        return players.values().toArray(players_arr);
    }
}
