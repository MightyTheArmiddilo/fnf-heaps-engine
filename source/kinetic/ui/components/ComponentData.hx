package kinetic.ui.components;

typedef ComponentData =
{
  var type:Class<Any>;
  var x:Float;
  var y:Float;
  var width:Float;
  var height:Float;
  var children:Array<ComponentData>;
  var extra:ComponentExtraData;
}

typedef ComponentExtraData =
{
  var name:String;
  var fields:Array<ComponentDataEntry>;
}

typedef ComponentDataEntry =
{
  var name:String;
  var type:Array<Dynamic>;
  var defaultValue:Dynamic;
}
