--- orig/al.java	2010-11-04 23:53:06.000000000 -0500
+++ src/al.java	2010-11-06 17:23:34.000000000 -0500
@@ -7,5 +7,13 @@
   {
     this.a = paramString;
     this.b = paramet;
+
+        ICommandIssuer command_issuer;
+        if (paramet.c().equals("CONSOLE")) {
+            command_issuer = Console.GetInstance();
+        } else {
+            command_issuer = PlayerManager.GetByName(paramet.c());
+        }
+        Mooncraft.Callback.ServerCommand.call(command_issuer, paramString);
   }
 }
\ No newline at end of file
