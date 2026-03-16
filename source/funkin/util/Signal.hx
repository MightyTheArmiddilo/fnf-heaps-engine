package funkin.util;

import haxe.Constraints.Function;

class Signal<T:Function>
{
  public var handlers:Array<SignalHandler<T>> = [];

  public var dispatch:T;

  public function new(?dispatch:T)
  {
    this.dispatch = dispatch;
  }

  public function add(listener:T)
  {
    if (listener != null) handlers.push(new SignalHandler(listener, false));
  }

  public function addOnce(listener:T)
  {
    if (listener != null) handlers.push(new SignalHandler(listener, true));
  }

  public function remove(listener:T):Void
  {
    if (listener != null)
    {
      var handler = null;

      for (h in handlers)
      {
        if (h.listener == listener) handler = h;
      }

      if (handler != null)
      {
        handlers.remove(handler);
      }
    }
  }

  public function has(listener:T):Bool
  {
    if (listener == null) return false;

    for (h in handlers)
    {
      if (h != null && h.listener == listener) return true;
    }

    return false;
  }

  public function destroy():Void
  {
    handlers = null;
  }
}

class SignalHandler<T:Function>
{
  public var listener:T;
  public var dispatchOnce(default, null):Bool;

  public function new(listener:T, dispatchOnce:Bool)
  {
    this.listener = listener;
    this.dispatchOnce = dispatchOnce;
  }

  public function destroy()
  {
    listener = null;
  }
}
