package funkin.game.notes.notestyles;

import funkin.data.AnimationData.Animation;
import funkin.data.NoteStyleData;
import funkin.objects.Anim;
import funkin.util.SpritesheetUtil;

class NoteStyle
{
  public final id:String;

  public final data:NoteStyleData;

  public function new(id:String, data:NoteStyleData)
  {
    this.id = id;
    this.data = data;
  }

  public function constructStrumNote(note:Anim, dir:Int):Anim
  {
    var anims = SpritesheetUtil.fromSparrow('${data.assets.strum.assetPath}.png', '${data.assets.strum.assetPath}.xml');

    var dirData = switch (dir)
    {
      case 0:
        data.assets.strum.data.left;
      case 1:
        data.assets.strum.data.down;
      case 2:
        data.assets.strum.data.up;
      case 3:
        data.assets.strum.data.right;
      default:
        data.assets.strum.data.left;
    };

    var idle = new Animation();
    idle.frames = SpritesheetUtil.ofPrefixes(anims, [dirData.idle.prefix]);
    idle = SpritesheetUtil.dataToAnimation(SpritesheetUtil.toNamed(dirData.idle, 'idle'), idle);
    idle = SpritesheetUtil.addOffsets(idle);
    note.animList['idle'] = idle;

    var press = new Animation();
    press.frames = SpritesheetUtil.ofPrefixes(anims, [dirData.press.prefix]);
    press = SpritesheetUtil.dataToAnimation(SpritesheetUtil.toNamed(dirData.press, 'press'), press);
    press = SpritesheetUtil.addOffsets(press);
    note.animList['press'] = press;

    var confirm = new Animation();
    confirm.frames = SpritesheetUtil.ofPrefixes(anims, [dirData.confirm.prefix]);
    confirm = SpritesheetUtil.dataToAnimation(SpritesheetUtil.toNamed(dirData.confirm, 'confirm'), confirm);
    confirm = SpritesheetUtil.addOffsets(confirm);
    note.animList['confirm'] = confirm;

    var confirmHold = new Animation();
    confirmHold.frames = SpritesheetUtil.ofPrefixes(anims, [dirData.confirmHold.prefix]);
    confirmHold = SpritesheetUtil.dataToAnimation(SpritesheetUtil.toNamed(dirData.confirmHold, 'confirmHold'), confirmHold);
    confirmHold = SpritesheetUtil.addOffsets(confirmHold);
    note.animList['confirm-loop'] = confirmHold;

    note.smooth = !data.pixel;
    note.scaleX = data.assets.strum.scale[0];
    note.scaleY = data.assets.strum.scale[1];

    return note;
  }

  public function toString():String
  {
    return 'NoteStyle<$id>';
  }
}
