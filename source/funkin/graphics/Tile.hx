package funkin.graphics;

@:access(h2d.Tile)
class Tile extends h2d.Tile
{
  public var name:String;

  public var rotation:Float = 0;

  public var skewX:Float = 0;
  public var skewY:Float = 0;

  override public function sub(x:Float, y:Float, w:Float, h:Float, dx:Float = 0, dy:Float = 0):Tile
  {
    var t = new Tile(innerTex, this.x + x, this.y + y, w, h, dx, dy);
    t.name = name;
    t.rotation = rotation;
    t.skewX = skewX;
    t.skewY = skewY;
    return t;
  }

  public static function fromh2d(t:h2d.Tile):Tile
  {
    var newT = new Tile(t.innerTex, t.x, t.y, t.width, t.height, t.dx, t.dy);
    newT.u = t.u;
    newT.v = t.v;
    newT.u2 = t.u2;
    newT.v2 = t.v2;
    newT.xFlip = t.xFlip;
    newT.yFlip = t.yFlip;

    return newT;
  }
}
