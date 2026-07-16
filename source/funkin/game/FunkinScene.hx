package funkin.game;

import h2d.Text;
import funkin.graphics.Tile;
import funkin.graphics.Sprite;
import funkin.game.notes.StrumlineNote;
import hxd.Event;
import funkin.util.vslice.VSliceChartConverter;
import funkin.game.notes.Strumline;
import hxd.Key;
import hxd.res.Sound;
import funkin.ui.MusicBeatScene;
import hxd.Res;
import funkin.input.Controls;
import h2d.RenderContext;

/**
 * The Scene holding the main gameplay of Friday Night Funkin'.
 */
@:access(hxd.res.Sound)
class FunkinScene extends MusicBeatScene
{
  var songId:String = 'dadbattle';

  var inst:Sound;
  var oppVocals:Sound;
  var playerVocals:Sound;

  var gamePaused:Bool = false;

  var playerStrumline:Strumline;

  override public function create()
  {
    super.create();

    var bg = new Sprite(this);
    bg.tile = Tile.fromh2d(h2d.Tile.fromColor(0xFF555555, width, height));

    inst = Res.load('game/songs/$songId/Inst.ogg').toSound();
    oppVocals = Res.load('game/songs/$songId/Voices-dad.ogg').toSound();
    playerVocals = Res.load('game/songs/$songId/Voices-bf.ogg').toSound();

    playerStrumline = new Strumline(this, 'funkin', inst);
    playerStrumline.x = (width / 2 + Constants.STRUMLINE_X_OFFSET);
    playerStrumline.y = Preferences.downscroll ? height - playerStrumline.getBounds().height - Constants.STRUMLINE_Y_OFFSET : Constants.STRUMLINE_Y_OFFSET;

    playerStrumline.loadFromChart(VSliceChartConverter.convertChart(Res.load('game/songs/dadbattle/chart.json').toText()));

    startSong();
  }

  public function startSong():Void
  {
    inst.play();
    oppVocals.play();
    playerVocals.play();
  }

  override public function keyPush(event:ControlEvent)
  {
    if (Controls.get('noteLeft').recognizesKey(event.keyCode)) playerStrumline.playPress(0);
    if (Controls.get('noteDown').recognizesKey(event.keyCode)) playerStrumline.playPress(1);
    if (Controls.get('noteUp').recognizesKey(event.keyCode)) playerStrumline.playPress(2);
    if (Controls.get('noteRight').recognizesKey(event.keyCode)) playerStrumline.playPress(3);
  }

  override public function keyUp(event:ControlEvent)
  {
    if (Controls.get('noteLeft').recognizesKey(event.keyCode)) playerStrumline.playStatic(0);
    if (Controls.get('noteDown').recognizesKey(event.keyCode)) playerStrumline.playStatic(1);
    if (Controls.get('noteUp').recognizesKey(event.keyCode)) playerStrumline.playStatic(2);
    if (Controls.get('noteRight').recognizesKey(event.keyCode)) playerStrumline.playStatic(3);
  }

  override function sync(ctx:RenderContext)
  {
    super.sync(ctx);

    if (Key.isPressed(Key.ENTER))
    {
      if (!gamePaused)
      {
        inst.channel.pause = true;
        oppVocals.channel.pause = true;
        playerVocals.channel.pause = true;

        gamePaused = true;
      }
      else
      {
        inst.channel.pause = false;
        oppVocals.channel.pause = false;
        playerVocals.channel.pause = false;

        gamePaused = false;
      }
    }

    if (Key.isPressed(Key.P))
    {
      playerStrumline.noteStyleId = playerStrumline.noteStyleId == 'funkin' ? 'pixel' : 'funkin';
    }

    if (Key.isPressed(Key.NUMBER_1))
    {
      playerStrumline.noteFromData({time: (@:privateAccess playerStrumline.connectedSound.channel.position ?? 0) * 1000 + 1000, dir: 0});
    }

    if (Key.isPressed(Key.NUMBER_2))
    {
      playerStrumline.noteFromData({time: (@:privateAccess playerStrumline.connectedSound.channel.position ?? 0) * 1000 + 1000, dir: 1});
    }

    if (Key.isPressed(Key.NUMBER_3))
    {
      playerStrumline.noteFromData({time: (@:privateAccess playerStrumline.connectedSound.channel.position ?? 0) * 1000 + 1000, dir: 2});
    }

    if (Key.isPressed(Key.NUMBER_4))
    {
      playerStrumline.noteFromData({time: (@:privateAccess playerStrumline.connectedSound.channel.position ?? 0) * 1000 + 1000, dir: 3});
    }

    if (playerStrumline.notes.children[0] != null
      && (@:privateAccess playerStrumline.connectedSound.channel.position ?? 0) * 1000
        - cast(playerStrumline.notes.children[0], funkin.game.notes.Note).time >= 0)
    {
      playerStrumline.notes.removeChild(playerStrumline.notes.children[0]);
    }
  }

  override function dispose()
  {
    super.dispose();

    inst.stop();
    oppVocals.stop();
    playerVocals.stop();
  }
}
