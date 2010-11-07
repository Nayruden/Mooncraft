--- orig/jc.java	2010-11-04 23:53:10.000000000 -0500
+++ src/jc.java	2010-11-06 23:50:09.000000000 -0500
@@ -66,7 +66,7 @@
         d1 = paramgx.a;
         d2 = paramgx.b;
         d3 = paramgx.c;
-        d4 = paramgx.d - paramgx.b;
+        double d4 = paramgx.d - paramgx.b;
         if ((d4 > 1.65D) || (d4 < 0.1D)) {
           c("Illegal stance");
           a.warning(this.e.ar + " had an illegal stance: " + d4);
@@ -188,6 +188,9 @@
   }
 
   public void a(String paramString) {
+    Player player = PlayerManager.GetByName(this.e.ar);
+    Mooncraft.Callback.PlayerDisconnect.call(player, paramString);
+    
     a.info(this.e.ar + " lost connection: " + paramString);
     this.d.f.c(this.e);
     this.c = true;
@@ -240,7 +243,20 @@
       }
     }
 
+    Player player = PlayerManager.GetByName(this.e.ar);
+    Object result = Mooncraft.Callback.PlayerChat.call(player, str);
+    if (result != null) {
+      str = result.toString();
+      if (str.isEmpty()) { // Wants to be blocked
+        return;
+      }
+    }
+
     if (str.startsWith("/")) {
+      Object res = Mooncraft.Callback.ClientCommand.call(player, str.substring(1));
+      if (res != null) { // Wants to be blocked
+          return;
+      }
       d(str);
     } else {
       str = "<" + this.e.ar + "> " + str;
