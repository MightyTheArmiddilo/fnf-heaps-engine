package funkin.game.notes.notestyles;

import funkin.data.NoteStyleData;
import funkin.graphics.Sprite;
import funkin.util.animation.AnimationUtil;

/**
 * A class for handling a note style,
 * including functions for providing
 * note style components.
 */
class NoteStyle
{
  public final id:String;

  public final data:NoteStyleData;

  public function new(id:String, data:NoteStyleData)
  {
    this.id = id;
    this.data = data;
  }

  public function constructStrumNote(note:Sprite, dir:Int):Sprite
  {
    note.clearAnimations();

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

    var path = data.assets.strum.assetPath;
    var xml = '$path.xml';
    var png = '$path.png';

    note.addAnimation(AnimationUtil.animationFromData('idle', dirData.idle, xml, png));
    note.addAnimation(AnimationUtil.animationFromData('press', dirData.press, xml, png));
    note.addAnimation(AnimationUtil.animationFromData('confirm', dirData.confirm, xml, png));
    note.addAnimation(AnimationUtil.animationFromData('confirmHold', dirData.confirmHold, xml, png));

    note.smooth = !data.pixel;
    note.scaleX = data.assets.strum.scale[0];
    note.scaleY = data.assets.strum.scale[1];

    return note;
  }

  public function constructNote(note:Sprite, dir:Int):Sprite
  {
    note.clearAnimations();

    var dirData = switch (dir)
    {
      case 0:
        data.assets.note.data.left;
      case 1:
        data.assets.note.data.down;
      case 2:
        data.assets.note.data.up;
      case 3:
        data.assets.note.data.right;
      default:
        data.assets.note.data.left;
    };

    var path = data.assets.note.assetPath;
    var xml = '$path.xml';
    var png = '$path.png';
    note.addAnimation(AnimationUtil.animationFromData('idle', dirData, xml, png));

    note.smooth = !data.pixel;
    note.scaleX = data.assets.note.scale[0];
    note.scaleY = data.assets.note.scale[1];

    return note;
  }

  public function toString():String
  {
    return 'NoteStyle<$id>';
  }
}
