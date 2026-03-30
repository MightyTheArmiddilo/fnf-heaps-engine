package funkin.game.notes;

import funkin.objects.Anim;
import funkin.game.notes.notestyles.NoteStyle;
import funkin.data.NoteStyleHandler;

class StrumlineNote extends Anim
{
  public var noteStyleId(default, set):String = 'funkin';

  function set_noteStyleId(value:String):String
  {
    noteStyleId = value;
    noteStyle.constructStrumNote(this, direction);
    return noteStyleId;
  }

  public var noteStyle(get, never):NoteStyle;

  function get_noteStyle():NoteStyle
  {
    return NoteStyleHandler.noteStyles[noteStyleId];
  }

  public var direction:Int = 0;

  public function new(?parent:h2d.Object, noteStyleId:String = 'funkin', dir:Int = 0)
  {
    super(null, 24, parent);

    this.noteStyleId = noteStyleId;

    direction = dir;
    noteStyle.constructStrumNote(this, direction);
  }
}
