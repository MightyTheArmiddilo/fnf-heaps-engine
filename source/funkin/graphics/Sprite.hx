package funkin.graphics;

import h2d.Object;
import h2d.RenderContext;
import h2d.col.Matrix;
import h2d.Drawable;

@:access(h2d.col.Matrix)
class Sprite extends Drawable
{
  public var tile(default, set):Tile;

  function set_tile(t)
  {
    if (tile == t) return t;
    tile = t;
    onContentChanged();
    return t;
  }

  public var width(default, set):Null<Float>;

  function set_width(w)
  {
    if (width == w) return w;
    width = w;
    onContentChanged();
    return w;
  }

  public var height(default, set):Null<Float>;

  function set_height(h)
  {
    if (height == h) return h;
    height = h;
    onContentChanged();
    return h;
  }

  public var curAnim:Animation;
  public var curFrame:Null<Int>;

  var timer:Null<Float>;

  public var isPlaying:Null<Bool> = false;
  public var finished:Null<Bool> = false;

  public var animations:Array<Animation>;

  public var skewX:Float = 0;
  public var skewY:Float = 0;

  public var showHitbox:Bool = false;
  public var hitbox:Sprite;

  public var centerX:Float = 0;
  public var centerY:Float = 0;

  public function new(?parent:Object, hasHitbox:Bool = false)
  {
    super(parent);

    animations = [];

    if (hasHitbox)
    {
      hitbox = new Sprite(this);
      hitbox.tile = Tile.fromh2d(h2d.Tile.fromColor(0xFFFF00FF, 1, 1, 0.25));
      hitbox.visible = showHitbox;
    }
  }

  public function playAnim(name:String):Void
  {
    if (animations == null) return;
    curFrame = 0;
    curAnim = getAnimation(name);
    timer = 0;
    isPlaying = true;
    finished = false;
    tile = curAnim.getTileFromIndex(curFrame);
  }

  public function addAnimation(anim:Animation):Void
  {
    animations.push(anim);
  }

  public function clearAnimations():Void
  {
    animations = [];
    curAnim = null;
    curFrame = null;
    timer = null;
    isPlaying = null;
    finished = null;
  }

  public function getAnimation(name:String):Null<Animation>
  {
    var r:Animation = null;
    for (anim in animations)
    {
      if (anim.name == name)
      {
        r = anim;
        break;
      }
    }
    return r;
  }

  public function loadFromImage(path:String):Void
  {
    clearAnimations();
    tile = Tile.fromh2d(hxd.Res.load(path).toTile());
  }

  public function skew(v:Float):Void
  {
    skewX *= v;
    skewY *= v;
  }

  public function setSkew(v:Float):Void
  {
    skewX = v;
    skewY = v;
  }

  public function resetCenter():Void
  {
    centerX = tile.width / 2;
    centerY = tile.height / 2;
  }

  override function sync(ctx:RenderContext)
  {
    super.sync(ctx);

    if (timer != null && curFrame != null && curAnim != null && animations.length > 0 && isPlaying)
    {
      timer += ctx.elapsedTime * curAnim.frameRate;
      var frameCount = 0;
      while (timer >= 1)
      {
        timer -= 1;
        frameCount++;
      }

      curFrame += frameCount;

      if (curFrame > curAnim.frames.length - 1)
      {
        if (curAnim.loop)
        {
          curFrame -= curAnim.frames.length;
        }
        else
        {
          curFrame = curAnim.frames.length - 1;
          finished = true;
        }
      }

      tile = curAnim.getTileFromIndex(curFrame);

      if (finished) isPlaying = false;
    }

    if (hitbox != null)
    {
      hitbox.tile.setSize(tile.width, tile.height);
      hitbox.tile.dx = tile.dx / 2;
      hitbox.tile.dy = tile.dy / 2;
      hitbox.tile.rotation = tile.rotation;
      hitbox.tile.skewX = tile.skewX;
      hitbox.tile.skewY = tile.skewY;
      hitbox.visible = showHitbox;
    }
  }

  override function draw(ctx:RenderContext)
  {
    if (width == null && height == null)
    {
      emitTile(ctx, tile);
      return;
    }
    if (tile == null) tile = Tile.fromh2d(h2d.Tile.fromColor(0xFF00FF));
    var ow = tile.width;
    var oh = tile.height;
    @:privateAccess {
      tile.width = width != null ? width : ow * height / oh;
      tile.height = height != null ? height : oh * width / ow;
    }
    emitTile(ctx, tile);
    @:privateAccess {
      tile.width = ow;
      tile.height = oh;
    }
  }

  override function getBoundsRec(relativeTo:Object, out:h2d.col.Bounds, forSize:Bool)
  {
    super.getBoundsRec(relativeTo, out, forSize);
    if (tile != null)
    {
      if (width == null && height == null) addBounds(relativeTo, out, tile.dx, tile.dy, tile.width, tile.height);
      else
        addBounds(relativeTo, out, tile.dx, tile.dy, width != null ? width : tile.width * height / tile.height,
          height != null ? height : tile.height * width / tile.width);
    }
  }

  // adjusted this a bit but thanks to the goated techniktil for most of this
  override function emitTile(ctx:RenderContext, tile:h2d.Tile)
  {
    if (!(tile is Tile))
    {
      super.emitTile(ctx, tile);
      return;
    }

    var tile:Tile = cast tile;

    var mat = new Matrix();

    mat.identity();

    final offsetX:Float = ((tile.width * scaleX) - tile.width) / 2;
    final offsetY:Float = ((tile.height * scaleY) - tile.height) / 2;

    final centerX:Float = tile.width / 2;
    final centerY:Float = tile.height / 2;

    mat.translate(-centerX, -centerY);
    mat.translate(tile.dx, tile.dy);
    mat.rotate(tile.rotation);
    mat.skew(tile.skewX, tile.skewY);

    if (tile.xFlip)
    {
      mat.scale(-1, 1);
      mat.translate(tile.width, 0);
    }

    if (tile.yFlip)
    {
      mat.scale(1, -1);
      mat.translate(0, tile.height);
    }

    mat.scale(scaleX, scaleY);
    mat.rotate(rotation);
    mat.skew(skewX, skewY);
    mat.translate(x + offsetX, y + offsetY);

    mat.translate(centerX, centerY);

    if (parent != null)
    {
      Matrix.tmp.a = parent.matA;
      Matrix.tmp.b = parent.matB;
      Matrix.tmp.c = parent.matC;
      Matrix.tmp.d = parent.matD;
      Matrix.tmp.x = parent.absX;
      Matrix.tmp.y = parent.absY;
      mat.multiply(mat, Matrix.tmp);
    }

    matA = mat.a;
    matB = mat.b;
    matC = mat.c;
    matD = mat.d;
    absX = mat.x;
    absY = mat.y;
    super.emitTile(ctx, tile);
  }
}
