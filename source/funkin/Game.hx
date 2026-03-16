package funkin;

import hxd.App;
import hxd.Res;
import hxd.res.Sound;
import hxd.Window;
// import hl.Native;
import h3d.Engine;
import h2d.Scene;
import h2d.Bitmap;
import funkin.util.Signal;

class Game extends App
{
  public var updateSignal:Signal<Float->Void>;

  public var startingScene:Class<Scene> = Scene;

  public function new(?startingScene:Class<Scene>)
  {
    super();

    if (startingScene != null) this.startingScene = startingScene;
  }

  override function init()
  {
    Res.initLocal();

    updateSignal = new Signal<Float->Void>(function(dt:Float) {
      for (h in updateSignal.handlers)
      {
        if (h == null || h.listener == null) continue;
        h.listener(dt);
        if (h.dispatchOnce) updateSignal.remove(h.listener);
      }
    });

    setScene(Type.createInstance(startingScene, []));
  }

  override function update(dt:Float):Void
  {
    updateSignal.dispatch(dt);
  }
}
