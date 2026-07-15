package funkin.util;

@:access(Main)
class ReloadUtil
{
  public static function reloadAssets():Void
  {
    trace('Reloading...');

    var assetsPath = #if REDIRECT_ASSETS '../../../../' + #end
    'assets';

    hxd.Res.loader.dispose();
    Main.setupFileSystem(assetsPath);
    Main.initializeClasses();

    for (app in Global.contexts)
    {
      var s2d = app.app.s2d;
      var cls = Type.getClass(s2d);
      var constructor = function() {
        return Type.createInstance(cls, []);
      };
      if (s2d is funkin.ui.Scene && cast(s2d, funkin.ui.Scene).constructor != null) constructor = cast(s2d, funkin.ui.Scene).constructor;
      app.app.setScene(constructor());

      if (app is Game)
      {
        var savedConstructors = [];
        var game:Game = cast app;

        while (game.topScenes.length > 0)
        {
          var scene = game.topScenes[0];
          var cls = Type.getClass(scene);
          var constructor = function() {
            return Type.createInstance(cls, []);
          };

          if (scene is funkin.ui.Scene
            && cast(scene, funkin.ui.Scene).constructor != null) constructor = cast(scene, funkin.ui.Scene).constructor;

          game.removeScene2D(scene);
        }

        for (constructor in savedConstructors)
        {
          game.addScene2D(constructor());
        }
      }
    }
  }
}
