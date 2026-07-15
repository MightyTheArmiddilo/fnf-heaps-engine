package funkin.util.animation;

import funkin.data.AnimationData;
import funkin.data.AnimationData.UnnamedAnimationData;
import funkin.graphics.Animation;
import funkin.graphics.Tile;

class AnimationUtil
{
  public static function toNamed(data:UnnamedAnimationData, name:String):AnimationData
  {
    return {
      name: name,
      prefix: data.prefix,
      offsets: data.offsets,
      loop: data.loop,
      flip: data.flip,
      frameRate: data.frameRate,
      indices: data.indices,
      animType: data.animType,
      renderType: data.renderType,
    };
  }

  public static function toUnnamed(data:AnimationData):UnnamedAnimationData
  {
    return {
      prefix: data.prefix,
      offsets: data.offsets,
      loop: data.loop,
      flip: data.flip,
      frameRate: data.frameRate,
      indices: data.indices,
      animType: data.animType,
      renderType: data.renderType,
    };
  }

  public static function animationFromData(name:String, animationData:UnnamedAnimationData, sparrowPath:String, imagePath:String):Animation
  {
    var sparrow = SparrowUtil.sparrowFromXml(sparrowPath);
    var anim = new Animation(name, Tile.fromh2d(hxd.Res.load(imagePath).toTile()));

    var frames:Array<AnimationFrame> = [];
    for (frame in SparrowUtil.framesWithPrefixes(sparrow, [animationData.prefix]))
      frames.push(new SparrowFrame(frame));

    anim.frames = frames.copy();
    anim.offsets = animationData.offsets?.copy() ?? [0, 0];
    anim.flip = animationData.flip?.copy() ?? [false, false];
    anim.loop = animationData.loop ?? false;
    anim.frameRate = animationData.frameRate ?? 24;

    sparrow = null;
    frames = null;

    return anim;
  }
}
