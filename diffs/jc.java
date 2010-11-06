--- orig/jc.java	2010-11-04 23:53:10.000000000 -0500
+++ src/jc.java	2010-11-05 19:13:20.000000000 -0500
@@ -66,7 +66,7 @@
         d1 = paramgx.a;
         d2 = paramgx.b;
         d3 = paramgx.c;
-        d4 = paramgx.d - paramgx.b;
+        double d4 = paramgx.d - paramgx.b;
         if ((d4 > 1.65D) || (d4 < 0.1D)) {
           c("Illegal stance");
           a.warning(this.e.ar + " had an illegal stance: " + d4);
@@ -240,6 +240,8 @@
       }
     }
 
+    Mooncraft.Callback.PlayerChat.call(PlayerManager.GetPlayer(this.e.ar), str);
+
     if (str.startsWith("/")) {
       d(str);
     } else {
