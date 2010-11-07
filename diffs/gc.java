--- orig/gc.java
+++ src/gc.java	2010-11-07 13:09:55.000000000 -0600
@@ -2,7 +2,10 @@
 import java.util.logging.FileHandler;
 import java.util.logging.Handler;
 import java.util.logging.Level;
+import java.util.logging.LogRecord;
 import java.util.logging.Logger;
+import java.util.regex.Matcher;
+import java.util.regex.Pattern;
 
 public class gc
 {
@@ -24,5 +27,37 @@
     } catch (Exception localException) {
       a.log(Level.WARNING, "Failed to log to server.log", localException);
     }
+    
+    a.addHandler(new Handler() {
+      Pattern pattern = Pattern.compile("^Starting minecraft server version ([0-9\\._]+)$");
+
+      @Override
+      public void publish(LogRecord record) {
+        Matcher matcher = pattern.matcher(record.getMessage());
+        a.removeHandler(this);
+        if (matcher.matches()) {
+          Server.MinecraftServerVersion = matcher.group(1);
+          if (!Server.MinecraftServerVersion.equals(Server.CompiledAgainstVersion)) {
+            a.warning("Mooncraft was built against Minecraft version " + 
+              Server.CompiledAgainstVersion +  ", which isn't what you're " +
+              "currently running. Depending on how much the API has changed, " +
+              "you may experience some errors.");
+          }
+        } else {
+          a.warning("Was unable to retrieve Minecraft server version for Mooncraft.");
+          a.warning("Please report this problem to the Mooncraft devs as soon as possible.");
+        }
+
+        Mooncraft.Callback.Init.call(); // For logging's sake, we want Lua init after this first message.
+      }
+
+      @Override
+      public void flush() {
+      }
+
+      @Override
+      public void close() throws SecurityException {
+      }
+    });
   }
 }
\ No newline at end of file
