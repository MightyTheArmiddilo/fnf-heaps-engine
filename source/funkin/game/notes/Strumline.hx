package funkin.game.notes;

import funkin.game.notes.notestyles.NoteStyle;
import funkin.data.NoteStyleHandler;
import funkin.util.SpritesheetUtil;
import funkin.objects.Anim;
import hxd.Res;
import h2d.Bitmap;
import h2d.Object;

class Strumline extends Object
{
  public var strumlineNotes:Object;

  public var noteStyleId(default, set):String = 'funkin';

  function set_noteStyleId(value:String):String
  {
    noteStyleId = value;
    refreshNoteStyle();
    return noteStyleId;
  }

  public var noteStyle(get, never):NoteStyle;

  function get_noteStyle():NoteStyle
  {
    return NoteStyleHandler.noteStyles[noteStyleId];
  }

  public function new(?parent:Object, noteStyleId:String = 'funkin')
  {
    super(parent);

    this.noteStyleId = noteStyleId;

    strumlineNotes = new Object(this);

    for (i in 0...4)
    {
      var strumNote = new StrumlineNote(strumlineNotes, noteStyleId, i);
      strumNote.playAnim('idle');
      strumNote.x += i * 120;
    }
  }

  public function refreshNoteStyle():Void
  {
    if (strumlineNotes != null)
    {
      for (note in strumlineNotes.children)
      {
        cast(note, StrumlineNote).noteStyleId = noteStyleId;
        cast(note, StrumlineNote).playAnim('idle');
      }
    }
  }

  public function playConfirm(dir:Int)
  {
    cast(strumlineNotes.children[dir], StrumlineNote).playAnim('confirm');
  }

  public function playPress(dir:Int)
  {
    cast(strumlineNotes.children[dir], StrumlineNote).playAnim('press');
  }

  public function playStatic(dir:Int)
  {
    cast(strumlineNotes.children[dir], StrumlineNote).playAnim('idle');
  }
}
