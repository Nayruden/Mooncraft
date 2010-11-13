--- orig/je.java
+++ src/je.java	2010-11-12 20:49:49.000000000 -0600
@@ -54,11 +54,11 @@
         float f1 = this.e.v;
         float f2 = this.e.w;
         this.e.k.z();
-        d3 = this.e.p;
-        d4 = this.e.q;
+        double d3 = this.e.p;
+        double d4 = this.e.q;
         double d5 = this.e.r;
-        d6 = 0.0D;
-        d7 = 0.0D;
+        double d6 = 0.0D;
+        double d7 = 0.0D;
         if (paramgz.i) {
           f1 = paramgz.e;
           f2 = paramgz.f;
@@ -96,7 +96,7 @@
         d2 = paramgz.a;
         d3 = paramgz.b;
         d4 = paramgz.c;
-        d6 = paramgz.d - paramgz.b;
+        double d6 = paramgz.d - paramgz.b;
         if ((d6 > 1.65D) || (d6 < 0.1D)) {
           c("Illegal stance");
           a.warning(this.e.ar + " had an illegal stance: " + d6);
@@ -233,6 +233,9 @@
   }
 
   public void a(String paramString) {
+    Player player = PlayerManager.GetByName(this.e.ar);
+    Mooncraft.Callback.PlayerDisconnect.call(player, paramString);
+
     a.info(this.e.ar + " lost connection: " + paramString);
     this.d.f.c(this.e);
     this.c = true;
@@ -285,7 +288,20 @@
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
