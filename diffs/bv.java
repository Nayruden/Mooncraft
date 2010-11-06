--- orig/bv.java	2010-11-04 23:53:08.000000000 -0500
+++ src/bv.java	2010-11-06 11:28:05.000000000 -0500
@@ -5,7 +5,8 @@
   public bv(String paramString, MinecraftServer paramMinecraftServer)
   {
     super(paramString);
+    Server.server = paramMinecraftServer;
   }
-  public void run() { this.a.run();
+  public void run() { Server.server.run();
   }
 }
\ No newline at end of file
