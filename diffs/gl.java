--- orig/gl.java	2010-11-04 23:53:08.000000000 -0500
+++ src/gl.java	2010-11-05 18:37:23.000000000 -0500
@@ -17,9 +17,9 @@
   private MinecraftServer c;
   private ia d;
   private int e;
-  private Set f = new HashSet();
-  private Set g = new HashSet();
-  private Set h = new HashSet();
+  private Set<String> f = new HashSet<String>();
+  private Set<String> g = new HashSet<String>();
+  private Set<String> h = new HashSet<String>();
   private File i;
   private File j;
   private File k;
@@ -61,6 +61,9 @@
     }
     this.c.e.a(parameo);
     this.d.a(parameo);
+
+    Player player = PlayerManager.AddPlayer(parameo);
+    Mooncraft.Callback.PlayerConnect.call(player);
   }
 
   public void b(eo parameo) {
