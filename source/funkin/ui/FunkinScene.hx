package funkin.ui;

class FunkinScene extends h2d.Scene
{
  public function new()
  {
    super();

    cast(funkin.Host.contexts[0].app, Game).updateSignal.add(update);
  }

  function update(dt:Float):Void {}
}
