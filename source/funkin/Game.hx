package funkin;

import hxd.SceneEvents.InteractiveScene;
import hxd.App;
import h2d.Scene;
import funkin.util.Signal;

/**
 * This App has some extra features added to it for convenience.
 */
class Game extends App
{
  public var updateSignal:Signal<Float->Void>;

  public var startingScene:Class<Scene> = Scene;

  public var topScenes:Array<Scene> = [];

  public function new(?startingScene:Class<Scene>)
  {
    super();

    if (startingScene != null) this.startingScene = startingScene;
  }

  override function init()
  {
    updateSignal = new Signal<Float->Void>(function(dt:Float) {
      for (h in updateSignal.handlers)
      {
        if (h == null || h.listener == null) continue;
        h.listener(dt);
        if (h.dispatchOnce) updateSignal.remove(h.listener);
      }
    });

    if (startingScene != null) setScene(Type.createInstance(startingScene, []));
  }

  override function setScene(scene:InteractiveScene, disposePrevious:Bool = true)
  {
    super.setScene(scene, disposePrevious);

    if (scene is funkin.ui.Scene) cast(scene, funkin.ui.Scene).create();
  }

  override function update(dt:Float):Void
  {
    updateSignal.dispatch(dt);
  }

  override public function render(e:h3d.Engine)
  {
    super.render(e);
    for (s in topScenes)
      s?.render(e);
  }

  override function dispose()
  {
    super.dispose();

    for (s in topScenes)
      s?.dispose();
  }

  override function mainLoop()
  {
    hxd.Timer.update();
    sevents.checkEvents();
    if (isDisposed) return;
    update(hxd.Timer.dt);
    if (isDisposed) return;
    var dt = hxd.Timer.dt; // fetch again in case it's been modified in update()
    if (s2d != null) s2d.setElapsedTime(dt);
    if (s3d != null) s3d.setElapsedTime(dt);
    for (s in topScenes)
      s?.setElapsedTime(dt);
    engine.render(this);
  }

  public function addScene2D(scene:Scene):Scene
  {
    topScenes.push(scene);
    sevents.addScene(scene);
    scene.mark = mark;
    return scene;
  }

  public function removeScene2D(scene:Scene, dispose:Bool = true):Scene
  {
    topScenes.remove(scene);
    sevents.removeScene(scene);
    if (dispose) scene.dispose();
    return scene;
  }
}
