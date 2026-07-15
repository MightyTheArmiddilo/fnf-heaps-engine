package funkin.game.notes;

import funkin.data.SongData.SongNoteData;
import funkin.graphics.Sprite;
import funkin.game.notes.notestyles.NoteStyle;
import funkin.data.NoteStyleHandler;

/**
 * The moving notes that the player must hit.
 */
class Note extends Sprite
{
  public var time:Float;

  public var noteStyleId(default, set):String = 'funkin';

  function set_noteStyleId(value:String):String
  {
    noteStyleId = value;
    noteStyle.constructNote(this, direction);
    return noteStyleId;
  }

  public var noteStyle(get, never):NoteStyle;

  function get_noteStyle():NoteStyle
  {
    return NoteStyleHandler.noteStyles[noteStyleId];
  }

  public var direction:Int = 0;

  public function new(?parent:h2d.Object, noteStyleId:String = 'funkin', ?data:SongNoteData)
  {
    super(parent);

    this.noteStyleId = noteStyleId;

    direction = data.dir ?? 0;
    time = data.time;
    noteStyle.constructNote(this, direction);
    playAnim('idle');
  }
}
