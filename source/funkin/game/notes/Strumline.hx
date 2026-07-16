package funkin.game.notes;

import funkin.data.SongData.SongChartData;
import hxd.res.Sound;
import funkin.data.SongData.SongNoteData;
import funkin.game.notes.notestyles.NoteStyle;
import funkin.data.NoteStyleHandler;
import hxd.Res;
import h2d.Bitmap;
import h2d.Object;
import h2d.RenderContext;

/**
 * A group of objects all in relation to notes.
 */
@:access(hxd.res.Sound)
class Strumline extends Object
{
  public var strumlineNotes:Object;

  public var notes:Object;

  public var scrollSpeed:Float = 3.0;

  public var connectedSound:Null<Sound>;

  public var noteStyleId(default, set):String = 'funkin';

  public var noteSpacing:Float = 120;

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

  public function new(?parent:Object, noteStyleId:String = 'funkin', ?sound:Sound)
  {
    super(parent);

    connectedSound = sound;

    this.noteStyleId = noteStyleId;

    strumlineNotes = new Object(this);

    notes = new Object(this);

    for (i in 0...4)
    {
      var strumNote = new StrumlineNote(strumlineNotes, noteStyleId, i);
      strumNote.playAnim('idle');
      strumNote.resetCenter();
      strumNote.x += i * noteSpacing;
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
        cast(note, StrumlineNote).resetCenter();
      }
    }

    if (notes != null)
    {
      for (note in notes.children)
      {
        cast(note, Note).noteStyleId = noteStyleId;
        cast(note, Note).playAnim('idle');
      }
    }
  }

  public function updateNotes():Void
  {
    if (notes == null) return;

    for (note in notes)
    {
      note.y = (Preferences.downscroll ? 1 : -1) * ((connectedSound.channel.position ?? 0) * 1000 - cast(note, Note)
        .time) * scrollSpeed * Constants.PIXELS_PER_MS;
    }
  }

  public function loadFromChart(chart:SongChartData):Void
  {
    for (note in chart.notes)
    {
      noteFromData(note);
    }

    scrollSpeed = chart.scrollSpeed;
  }

  public function noteFromData(noteData:SongNoteData):Note
  {
    var note = new Note(notes, noteStyleId, noteData);
    note.y = (Preferences.downscroll ? 1 : -1) * note.time * scrollSpeed * Constants.PIXELS_PER_MS;
    note.x = note.direction * noteSpacing;
    return note;
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

  override public function sync(ctx:RenderContext)
  {
    super.sync(ctx);

    updateNotes();
  }
}
