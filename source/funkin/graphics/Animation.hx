package funkin.graphics;

import funkin.util.animation.SparrowData.SparrowFrameData;

class Animation
{
  public var name:String;

  public var frames:Array<AnimationFrame>;

  public var image:Tile;

  public var offsets:Array<Float>;

  public var loop:Bool;

  public var flip:Array<Bool>;

  public var frameRate:Int;

  public function new(name:String, image:Tile)
  {
    this.name = name;
    frames = [];
    this.image = image;
  }

  public function getTileFromIndex(index:Int):Null<Tile>
  {
    var t = frames[index]?.getTile(image);
    if (t == null) return null;
    t.dx += offsets[0];
    t.dy += offsets[1];
    return t;
  }

  public function getTileFromName(name:String):Null<Tile>
  {
    var t = getFrameWithName(name)?.getTile(image);
    if (t == null) return null;
    t.dx += offsets[0];
    t.dy += offsets[1];
    return t;
  }

  public function getFrameWithName(name:String):Null<AnimationFrame>
  {
    var f:Null<AnimationFrame> = null;

    for (frame in frames)
    {
      if (frame.name == name)
      {
        f = frame;
        break;
      }
    }

    return f;
  }
}

class SparrowFrame implements AnimationFrame
{
  public var name:String;

  public var data:SparrowFrameData;

  private var tile:Tile;

  public function new(data:SparrowFrameData)
  {
    this.data = data;
    name = data.name;
  }

  public function getTile(sourceTile:Tile):Tile
  {
    // if (tile != null) return tile;
    if (sourceTile == null) return null;
    tile = sourceTile.sub(data.x, data.y, data.width, data.height, -data.frameX, -data.frameY);
    return tile;
  }
}

interface AnimationFrame
{
  public var name:String;

  public function getTile(sourceTile:Tile):Tile;
}
