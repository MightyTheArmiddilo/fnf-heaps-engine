package funkin.game.notes;

import funkin.graphics.Tile;
import h2d.RenderContext;
import funkin.graphics.Sprite;
import funkin.game.notes.notestyles.NoteStyle;
import funkin.data.NoteStyleHandler;

/**
 * The static notes of a strumline that
 * mark when to hit the moving arrows.
 */
class StrumlineNote extends Sprite
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
    super(parent);

    this.noteStyleId = noteStyleId;

    direction = dir;
    noteStyle.constructStrumNote(this, direction);
  }

  override function playAnim(name:String)
  {
    super.playAnim(name);
  }

  override function set_tile(t:Tile):Tile
  {
    t.dx = centerX / 2 - t.width / 4;
    t.dy = centerY / 2 - t.height / 4;
    if (curAnim != null)
    {
      t.dx += curAnim.offsets[0];
      t.dy += curAnim.offsets[1];
    }

    return super.set_tile(t);
  }
}
