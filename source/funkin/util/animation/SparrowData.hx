package funkin.util.animation;

typedef SparrowData =
{
  var imagePath:String;
  var width:Int;
  var height:Int;
  var frames:Array<SparrowFrameData>;
}

typedef SparrowFrameData =
{
  var name:String;
  var x:Int;
  var y:Int;
  var width:Int;
  var height:Int;
  var ?rotated:Bool;
  var ?frameX:Int;
  var ?frameY:Int;
  var ?frameWidth:Int;
  var ?frameHeight:Int;
}
