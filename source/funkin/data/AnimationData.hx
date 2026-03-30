package funkin.data;

typedef AnimationData =
{
  > UnnamedAnimationData,

  var ?name:String;
}

typedef UnnamedAnimationData =
{
  var prefix:String;

  var ?offsets:Array<Float>;

  var ?loop:Bool;

  var ?flip:Array<Bool>;

  var ?frameRate:Int;

  var ?indices:Array<Int>;

  var ?animType:String;

  var ?renderType:String;
}

class Animation
{
  public var name:Null<String>;

  public var frames:Array<SpritesheetAnimData>;

  public var loop:Bool = false;

  public var offsets:Array<Float> = [0, 0];

  public var frameRate:Int = 24;

  public var flip:Array<Bool> = [false, false];

  public function new() {}

  public function toString():String
    return 'Animation<name: $name,frames: $frames,loop: $loop,offsets: $offsets,frameRate: $frameRate,flip: $flip>';
}
