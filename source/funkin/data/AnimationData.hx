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
