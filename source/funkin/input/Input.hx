package funkin.input;

import sys.thread.Thread;
import funkin.util.Signal;
import hxd.Window;
import hxd.Event;

/**
 * A class for much better handling of user input.
 * 
 * There's probably a much better way of doing this-
 */
class Input
{
  public static var keyPressed:Array<Float> = [];

  public static var keyThread:Thread;

  public static final keyDown:Signal<ControlEvent->Void> = new Signal<ControlEvent->Void>(function(event:ControlEvent) {
    for (h in keyDown.handlers)
    {
      if (h == null || h.listener == null) continue;
      h.listener(event);
      if (h.dispatchOnce) keyDown.remove(h.listener);
    }
  });

  public static final keyUp:Signal<ControlEvent->Void> = new Signal<ControlEvent->Void>(function(event:ControlEvent) {
    for (h in keyUp.handlers)
    {
      if (h == null || h.listener == null) continue;
      h.listener(event);
      if (h.dispatchOnce) keyUp.remove(h.listener);
    }
  });

  public static final keyPress:Signal<ControlEvent->Void> = new Signal<ControlEvent->Void>(function(event:ControlEvent) {
    for (h in keyPress.handlers)
    {
      if (h == null || h.listener == null) continue;
      h.listener(event);
      if (h.dispatchOnce) keyPress.remove(h.listener);
    }
  });

  public static final mousePush:Signal<ControlEvent->Void> = new Signal<ControlEvent->Void>(function(event:ControlEvent) {
    for (h in mousePush.handlers)
    {
      if (h == null || h.listener == null) continue;
      h.listener(event);
      if (h.dispatchOnce) mousePush.remove(h.listener);
    }
  });

  public static final mouseRelease:Signal<ControlEvent->Void> = new Signal<ControlEvent->Void>(function(event:ControlEvent) {
    for (h in mouseRelease.handlers)
    {
      if (h == null || h.listener == null) continue;
      h.listener(event);
      if (h.dispatchOnce) mouseRelease.remove(h.listener);
    }
  });

  public static final mouseReleaseOutside:Signal<ControlEvent->Void> = new Signal<ControlEvent->Void>(function(event:ControlEvent) {
    for (h in mouseReleaseOutside.handlers)
    {
      if (h == null || h.listener == null) continue;
      h.listener(event);
      if (h.dispatchOnce) mouseReleaseOutside.remove(h.listener);
    }
  });

  public static final mouseWheel:Signal<ControlEvent->Void> = new Signal<ControlEvent->Void>(function(event:ControlEvent) {
    for (h in mouseWheel.handlers)
    {
      if (h == null || h.listener == null) continue;
      h.listener(event);
      if (h.dispatchOnce) mouseWheel.remove(h.listener);
    }
  });

  public static function init():Void
  {
    for (key in Type.getClassFields(KeyCodes))
    {
      if (key != 'fromName' && key != 'fromInt')
      {
        keyPressed.push(0);
      }
    }

    Window.getInstance().addEventTarget(onEvent);

    // keyThread = Thread.createWithEventLoop(keyLoop);
  }

  /*static function keyLoop():Void
    {
      for (key in Type.getClassFields(KeyCodes))
      {
        if (key != 'fromName' && key != 'fromInt')
        {
          var code = Reflect.field(KeyCodes, key);
          if (Key.isDown(code))
          {
            keyDown.dispatch(new ControlEvent(code));
          }
        }
      }
  }*/
  static function onEvent(e:Event)
  {
    switch (e.kind)
    {
      case EKeyDown:
        keyDown.dispatch(new ControlEvent(e.keyCode));
        if (keyPressed[e.keyCode] <= 0)
        {
          keyPressed[e.keyCode] = haxe.Timer.stamp();
          keyPress.dispatch(new ControlEvent(e.keyCode));
        }
      case EKeyUp:
        keyUp.dispatch(new ControlEvent(e.keyCode));
        keyPressed[e.keyCode] = -haxe.Timer.stamp();
      case EPush:
        mousePush.dispatch(new ControlEvent(null, e.button));
      case ERelease:
        mouseRelease.dispatch(new ControlEvent(null, e.button));
      case EReleaseOutside:
        mouseReleaseOutside.dispatch(new ControlEvent(null, e.button));
      case EWheel:
        mouseWheel.dispatch(new ControlEvent(null, null, e.wheelDelta));
      default:
    }
  }
}
