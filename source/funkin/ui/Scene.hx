package funkin.ui;

class Scene extends h2d.Scene
{
  public function new()
  {
    super();

    cast(funkin.Host.contexts[0].app, Game).updateSignal.add(update);
  }

  function update(dt:Float):Void {}

  public function create():Void {}
}
