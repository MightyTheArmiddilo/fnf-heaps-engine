package funkin.ui;

import funkin.util.interfaces.IKeyReciever;

/**
 * This class is the same as a Scene but with some extra features.
 */
class Scene extends h2d.Scene implements IKeyReciever
{
  public function new()
  {
    super();

    initKeyEvents();
  }

  public function create():Void {}

  public function keyDown(event:ControlEvent):Void {}

  public function keyUp(event:ControlEvent):Void {}

  public function keyPush(event:ControlEvent):Void {}

  public function mousePush(event:ControlEvent):Void {}

  public function mouseRelease(event:ControlEvent):Void {}

  public function mouseReleaseOutside(event:ControlEvent):Void {}

  public function mouseWheel(event:ControlEvent):Void {}

  public function initKeyEvents():Void
  {
    Input.keyDown.add(keyDown);
    Input.keyUp.add(keyUp);
    Input.keyPress.add(keyPush);
    Input.mousePush.add(mousePush);
    Input.mouseRelease.add(mouseRelease);
    Input.mouseReleaseOutside.add(mouseReleaseOutside);
    Input.mouseWheel.add(mouseWheel);
  }
}
