package funkin.util.interfaces;

interface IKeyReciever
{
  public function keyDown(event:ControlEvent):Void;

  public function keyUp(event:ControlEvent):Void;

  public function keyPush(event:ControlEvent):Void;

  public function mousePush(event:ControlEvent):Void;

  public function mouseRelease(event:ControlEvent):Void;

  public function mouseReleaseOutside(event:ControlEvent):Void;

  public function mouseWheel(event:ControlEvent):Void;

  public function initKeyEvents():Void;
}
