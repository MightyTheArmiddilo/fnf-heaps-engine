package funkin.objects;

import funkin.data.AnimationData.Animation;
import h2d.Anim as HeapsAnim;
import funkin.data.SpritesheetAnimData;
import funkin.util.SpritesheetUtil;

class Anim extends HeapsAnim
{
  public var animList:Map<String, Animation> = [];

  public function playAnim(anim:String):Void
  {
    loop = animList[anim].loop;
    play(SpritesheetUtil.toTileArray(animList[anim].frames));
  }
}
