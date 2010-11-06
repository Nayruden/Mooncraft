/*
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send
 * a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco,
 * California, 94105, USA.
 */

public class Console implements ICommandIssuer {

    static Console console = new Console();

    public String GetName() {
        return "CONSOLE";
    }

    public boolean IsConsole() {
        return true;
    }

    static Console GetInstance() {
        return console;
    }
}
