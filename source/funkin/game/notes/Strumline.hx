package funkin.game.notes;

import h2d.Anim;
import hxd.Res;
import h2d.Bitmap;
import h2d.Object;

@:access(Xml)
class Strumline extends Object
{
  var strumlineNotes:Object;

  public function new(?parent:Object)
  {
    super(parent);

    strumlineNotes = new Object(this);

    for (i in 0...4)
    {
      // TODO: Move all this crap to its own class ;-;
      var image = Res.load('game/notestyles/funkin/assets/noteStrumline.png').toTile();
      var frames = [];
      var xml = Xml.parse(Res.load('game/notestyles/funkin/assets/noteStrumline.xml').toText());
      for (child in xml.children)
      {
        if (child.nodeType == Element)
        {
          for (c in child.children)
          {
            if (c.nodeType == Element)
            {
              if (c.nodeName == 'SubTexture')
              {
                frames.push(image.sub(Std.parseFloat(c.get('x')), Std.parseFloat(c.get('y')), Std.parseFloat(c.get('width')), Std.parseFloat(c.get('height')),
                  -Std.parseFloat(c.get('frameX')), -Std.parseFloat(c.get('frameY'))));
              }
            }
          }
        }
      }
      var strumNote = new Anim(frames, 24, strumlineNotes);
      strumNote.smooth = true;
      strumNote.play(frames);
      strumNote.x += i * 150;
      strumNote.scaleX = 0.7;
      strumNote.scaleY = 0.7;
    }
  }
}
