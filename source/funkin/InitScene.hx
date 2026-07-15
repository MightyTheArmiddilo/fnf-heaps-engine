package funkin;

/**
 * This Scene is a daughter to Main and sets up stuff that Main can't set up.
 */
@:access(Main)
class InitScene extends funkin.ui.Scene
{
  override public function create():Void
  {
    funkin.input.Controls.init();
    funkin.input.Input.init();

    cast(funkin.util.HeapsUtil.getAppWithScene(this).app, Game).updateSignal.add(Main.loopFunc);

    cast(funkin.util.HeapsUtil.getAppWithScene(this).app, Game).addScene2D(new funkin.ui.DebugScene());

    Global.contexts[0].app.setScene(new funkin.game.FunkinScene());
  }
}
