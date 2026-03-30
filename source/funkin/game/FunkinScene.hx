package funkin.game;

import funkin.game.notes.Strumline;
import hxd.Key;
import hxd.res.Sound;
import funkin.ui.MusicBeatScene;
import hxd.Res;

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

    playerStrumline = new Strumline(this, 'funkin');

    inst = Res.load('game/songs/$songId/Inst.ogg').toSound();
    oppVocals = Res.load('game/songs/$songId/Voices-dad.ogg').toSound();
    playerVocals = Res.load('game/songs/$songId/Voices-bf.ogg').toSound();

    startSong();
  }

  public function startSong():Void
  {
    inst.play();
    oppVocals.play();
    playerVocals.play();
  }

  override function update(dt:Float)
  {
    super.update(dt);

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

    if (Key.isPressed(Key.D))
    {
      playerStrumline.playPress(0);
    }
    else if (Key.isReleased(Key.D))
    {
      playerStrumline.playStatic(0);
    }

    if (Key.isPressed(Key.F))
    {
      playerStrumline.playPress(1);
    }
    else if (Key.isReleased(Key.F))
    {
      playerStrumline.playStatic(1);
    }

    if (Key.isPressed(Key.J))
    {
      playerStrumline.playPress(2);
    }
    else if (Key.isReleased(Key.J))
    {
      playerStrumline.playStatic(2);
    }

    if (Key.isPressed(Key.K))
    {
      playerStrumline.playPress(3);
    }
    else if (Key.isReleased(Key.K))
    {
      playerStrumline.playStatic(3);
    }

    if (Key.isPressed(Key.P))
    {
      playerStrumline.noteStyleId = playerStrumline.noteStyleId == 'funkin' ? 'pixel' : 'funkin';
    }
  }
}
