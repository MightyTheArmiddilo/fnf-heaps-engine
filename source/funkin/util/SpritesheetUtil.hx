package funkin.util;

import funkin.data.AnimationData;
import funkin.data.AnimationData.Animation;
import funkin.data.SpritesheetAnimData;

class SpritesheetUtil
{
  @:access(Xml)
  public static function fromSparrow(imagePath:String, dataPath:String):Array<SpritesheetAnimData>
  {
    var image = hxd.Res.load(imagePath).toTile();
    var frames = [];
    var xml = Xml.parse(hxd.Res.load(dataPath).toText());
    for (child in xml.elements())
    {
      for (c in child.elementsNamed('SubTexture'))
      {
        frames.push(
          {
            tile: image.sub(Std.parseFloat(c.get('x') ?? '0') ?? 0, Std.parseFloat(c.get('y') ?? '0'), Std.parseFloat(c.get('width') ?? '0'),
              Std.parseFloat(c.get('height') ?? '0'), -Std.parseFloat(c.get('frameX') ?? '0'), -Std.parseFloat(c.get('frameY') ?? '0')),
            name: c.get('name')
          });
      }
    }
    return frames;
  }

  public static function toTileArray(animations:Array<SpritesheetAnimData>):Array<h2d.Tile>
  {
    return [for (anim in animations) anim.tile];
  }

  public static function ofPrefixes(animations:Array<SpritesheetAnimData>, prefixes:Array<String>):Array<SpritesheetAnimData>
  {
    var r = [];
    for (anim in animations)
    {
      for (pref in prefixes)
        if (anim.name.startsWith(pref)) r.push(anim);
    }
    return r;
  }

  public static function dataToAnimation(data:AnimationData, ?anim:Animation):Animation
  {
    if (anim == null) anim = new Animation();

    anim.name = data.name;
    anim.offsets = data.offsets ?? [0., 0.];
    anim.flip = data.flip ?? [false, false];
    anim.loop = data.loop ?? false;
    anim.frameRate = data.frameRate ?? 24;

    return anim;
  }

  public static function addOffsets(anim:Animation):Animation
  {
    for (frame in anim.frames)
    {
      frame.tile.dx += anim.offsets[0] ?? 0;
      frame.tile.dy += anim.offsets[1] ?? 0;
    }

    return anim;
  }

  public static function toNamed(data:UnnamedAnimationData, name:String):AnimationData
  {
    var named:AnimationData =
      {
        name: name,
        prefix: data.prefix,
        offsets: data.offsets ?? [0., 0.],
        loop: data.loop ?? false,
        flip: data.flip ?? [false, false],
        frameRate: data.frameRate ?? 24,
        indices: data.indices,
        animType: data.animType ?? 'labels',
        renderType: data.renderType ?? 'sparrow'
      };
    named.name = name;
    return named;
  }
}
