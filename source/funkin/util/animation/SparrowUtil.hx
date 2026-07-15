package funkin.util.animation;

import funkin.util.animation.SparrowData.SparrowFrameData;

using StringTools;

/**
 * A utility class in relation to sparrow spritesheets.
 */
class SparrowUtil
{
  @:access(Xml)
  public static function sparrowFromXml(dataPath:String):SparrowData
  {
    var frames:Array<SparrowFrameData> = [];
    var xml = Xml.parse(hxd.Res.load(dataPath).toText());
    var r:SparrowData = null;

    for (child in xml.elements())
    {
      for (c in child.elementsNamed('SubTexture'))
      {
        var f:SparrowFrameData =
          {
            name: '',
            x: 0,
            y: 0,
            width: 0,
            height: 0
          };

        f.name = c.get('name');
        f.x = Std.parseInt(c.get('x'));
        f.y = Std.parseInt(c.get('y'));
        f.width = Std.parseInt(c.get('width'));
        f.height = Std.parseInt(c.get('height'));
        if (c.get('rotated') != null) f.rotated = (c.get('rotated') == 'true');
        if (c.get('frameX') != null) f.frameX = Std.parseInt(c.get('frameX'));
        if (c.get('frameY') != null) f.frameY = Std.parseInt(c.get('frameY'));
        if (c.get('frameWidth') != null) f.frameWidth = Std.parseInt(c.get('frameWidth'));
        if (c.get('frameHeight') != null) f.frameHeight = Std.parseInt(c.get('frameHeight'));

        frames.push(f);
      }

      r =
        {
          imagePath: child.get('imagePath'),
          width: Std.parseInt(child.get('width')),
          height: Std.parseInt(child.get('height')),
          frames: frames,
        };
    }

    return r;
  }

  public static function framesWithPrefixes(data:SparrowData, prefixes:Array<String>):Array<SparrowFrameData>
  {
    var frames = [];

    for (frame in data.frames)
    {
      if ([for (prefix in prefixes) frame.name.startsWith(prefix)].contains(true)) frames.push(frame);
    }

    return frames;
  }
}
