package funkin.input;

import sys.thread.Thread;
import haxe.MainLoop;
import funkin.util.Signal;
import hxd.Key;
import hxd.Window;
import hxd.Event;

/**
 * A sister class to Input, made for handling controls set by the user.
 */
class Controls
{
  private static final _keys:Map<String, FunkinKeybind> = [];

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

  public static var checkerThread:Thread;

  public static function init():Void
  {
    Window.getInstance().addEventTarget(onEvent);

    checkerThread = Thread.createWithEventLoop(checkerLoop);

    _keys['noteLeft'] = new FunkinKeybind(['D'], 'noteLeft');
    _keys['noteDown'] = new FunkinKeybind(['F'], 'noteDown');
    _keys['noteUp'] = new FunkinKeybind(['J'], 'noteUp');
    _keys['noteRight'] = new FunkinKeybind(['K'], 'noteRight');
  }

  static function onEvent(e:Event)
  {
    switch (e.kind)
    {
      case EKeyDown:
        keyDown.dispatch(new ControlEvent(e.keyCode));
      case EKeyUp:
        keyUp.dispatch(new ControlEvent(e.keyCode));
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

  static function checkerLoop():Void
  {
    for (key in Type.getClassFields(KeyCodes))
    {
      if (key != 'fromName' && key != 'fromInt')
      {
        var code = Reflect.field(KeyCodes, key);
        if (Key.isPressed(code)) keyPress.dispatch(new ControlEvent(code));
      }
    }
  }

  public static function get(bind:String):FunkinKeybind
  {
    return _keys[bind];
  }

  public static function setKeys(bind:String, newKeys:Array<String>):Void
  {
    _keys[bind].keys = newKeys;
  }
}

class ControlEvent
{
  public var keyCode(default, null):Null<Int>;

  public var button(default, null):Null<Int>;

  public var wheelDelta(default, null):Null<Float>;

  public function new(?keyCode:Int, ?button:Int, ?wheelDelta:Float)
  {
    this.keyCode = keyCode;
    this.button = button;
    this.wheelDelta = wheelDelta;
  }
}

class FunkinKeybind
{
  public var id:Null<String>;

  public var keys:Array<String> = [];

  public var down(get, null):Bool;

  function get_down():Bool
  {
    for (key in keys)
    {
      if (Key.isDown(KeyCodes.fromName(key))) return true;
    }

    return false;
  }

  public var pressed(get, null):Bool;

  function get_pressed():Bool
  {
    for (key in keys)
    {
      if (Key.isPressed(KeyCodes.fromName(key))) return true;
    }

    return false;
  }

  public var released(get, null):Bool;

  function get_released():Bool
  {
    for (key in keys)
    {
      if (Key.isReleased(KeyCodes.fromName(key))) return true;
    }

    return false;
  }

  public function new(?keys:Array<String>, ?id:String)
  {
    if (keys != null) this.keys = keys;
    this.id = id;
  }

  public function recognizesKey(keyCode:Int):Bool
  {
    for (key in keys)
    {
      if (KeyCodes.fromName(key) == keyCode) return true;
    }

    return false;
  }

  public function toString():String
  {
    return 'FunkinKeybind<keys=$keys, id=$id, down=$down, pressed=$pressed, released=$released>';
  }
}

class KeyCodes
{
  public static var BACKSPACE = 8;
  public static var TAB = 9;
  public static var ENTER = 13;
  public static var SHIFT = 16;
  public static var CTRL = 17;
  public static var ALT = 18;
  public static var ESCAPE = 27;
  public static var SPACE = 32;
  public static var PGUP = 33;
  public static var PGDOWN = 34;
  public static var END = 35;
  public static var HOME = 36;
  public static var LEFT = 37;
  public static var UP = 38;
  public static var RIGHT = 39;
  public static var DOWN = 40;
  public static var INSERT = 45;
  public static var DELETE = 46;

  public static var QWERTY_EQUALS = 187;
  public static var QWERTY_MINUS = 189;
  public static var QWERTY_TILDE = 192;
  public static var QWERTY_BRACKET_LEFT = 219;
  public static var QWERTY_BRACKET_RIGHT = 221;
  public static var QWERTY_SEMICOLON = 186;
  public static var QWERTY_QUOTE = 222;
  public static var QWERTY_BACKSLASH = 220;
  public static var QWERTY_COMMA = 188;
  public static var QWERTY_PERIOD = 190;
  public static var QWERTY_SLASH = 191;
  public static var INTL_BACKSLASH = 226;
  public static var LEFT_WINDOW_KEY = 91;
  public static var RIGHT_WINDOW_KEY = 92;
  public static var CONTEXT_MENU = 93;
  public static var AZERTY_EXCLAM = 223;

  public static var PAUSE_BREAK = 19;
  public static var CAPS_LOCK = 20;
  public static var NUM_LOCK = 144;
  public static var SCROLL_LOCK = 145;

  public static var NUMBER_0 = 48;
  public static var NUMBER_1 = 49;
  public static var NUMBER_2 = 50;
  public static var NUMBER_3 = 51;
  public static var NUMBER_4 = 52;
  public static var NUMBER_5 = 53;
  public static var NUMBER_6 = 54;
  public static var NUMBER_7 = 55;
  public static var NUMBER_8 = 56;
  public static var NUMBER_9 = 57;

  public static var NUMPAD_0 = 96;
  public static var NUMPAD_1 = 97;
  public static var NUMPAD_2 = 98;
  public static var NUMPAD_3 = 99;
  public static var NUMPAD_4 = 100;
  public static var NUMPAD_5 = 101;
  public static var NUMPAD_6 = 102;
  public static var NUMPAD_7 = 103;
  public static var NUMPAD_8 = 104;
  public static var NUMPAD_9 = 105;

  public static var A = 65;
  public static var B = 66;
  public static var C = 67;
  public static var D = 68;
  public static var E = 69;
  public static var F = 70;
  public static var G = 71;
  public static var H = 72;
  public static var I = 73;
  public static var J = 74;
  public static var K = 75;
  public static var L = 76;
  public static var M = 77;
  public static var N = 78;
  public static var O = 79;
  public static var P = 80;
  public static var Q = 81;
  public static var R = 82;
  public static var S = 83;
  public static var T = 84;
  public static var U = 85;
  public static var V = 86;
  public static var W = 87;
  public static var X = 88;
  public static var Y = 89;
  public static var Z = 90;

  public static var F1 = 112;
  public static var F2 = 113;
  public static var F3 = 114;
  public static var F4 = 115;
  public static var F5 = 116;
  public static var F6 = 117;
  public static var F7 = 118;
  public static var F8 = 119;
  public static var F9 = 120;
  public static var F10 = 121;
  public static var F11 = 122;
  public static var F12 = 123;

  public static var F13 = 124;
  public static var F14 = 125;
  public static var F15 = 126;
  public static var F16 = 127;
  public static var F17 = 128;
  public static var F18 = 129;
  public static var F19 = 130;
  public static var F20 = 131;
  public static var F21 = 132;
  public static var F22 = 133;
  public static var F23 = 134;
  public static var F24 = 135;

  public static var NUMPAD_MULT = 106;
  public static var NUMPAD_ADD = 107;
  public static var NUMPAD_ENTER = 108;
  public static var NUMPAD_SUB = 109;
  public static var NUMPAD_DOT = 110;
  public static var NUMPAD_DIV = 111;

  public static var MOUSE_LEFT = 0;
  public static var MOUSE_RIGHT = 1;
  public static var MOUSE_MIDDLE = 2;
  public static var MOUSE_BACK = 3;
  public static var MOUSE_FORWARD = 4;

  public static var MOUSE_WHEEL_UP = 5;
  public static var MOUSE_WHEEL_DOWN = 6;

  public static var LOC_LEFT = 256;
  public static var LOC_RIGHT = 512;

  public static var LSHIFT = SHIFT | LOC_LEFT;
  public static var RSHIFT = SHIFT | LOC_RIGHT;
  public static var LCTRL = CTRL | LOC_LEFT;
  public static var RCTRL = CTRL | LOC_RIGHT;
  public static var LALT = ALT | LOC_LEFT;
  public static var RALT = ALT | LOC_RIGHT;

  public static function fromName(name:String):Int
  {
    return Reflect.field(KeyCodes, name);
  }

  public static function fromInt(int:Int):String
  {
    return Key.getKeyName(int);
  }
}
