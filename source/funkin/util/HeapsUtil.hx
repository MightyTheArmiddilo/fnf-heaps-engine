package funkin.util;

import hxd.impl.AppContext;
import h2d.Scene;
import hxd.App;

class HeapsUtil
{
  public static function appHasScene(app:App, scene:Scene)
  {
    var r = app.s2d == scene;

    if (app is Game)
    {
      var castApp:Game = cast app;
      r = r || castApp.topScenes.contains(scene);
    }

    return r;
  }

  public static function getAppWithScene(scene:Scene):Null<AppContext>
  {
    for (a in Global.contexts)
    {
      if (HeapsUtil.appHasScene(a.app, scene)) return a;
    }

    return null;
  }
}
