package funkin.ui;

import funkin.util.MemoryUtil;
import h2d.Text;
import h2d.Bitmap;
import h2d.RenderContext;

class DebugScene extends Scene
{
  public var show(default, set):Bool = true;

  function set_show(value:Bool):Bool
  {
    show = value;

    if (value)
    {
      displayBG = new Bitmap(h2d.Tile.fromColor(0x353535, 200, 42, 0.5), this);
      fpsTxt = new Text(hxd.res.DefaultFont.get(), this);
      memTxt = new Text(hxd.res.DefaultFont.get(), this);
      displayBG.x += 10;
      displayBG.y += 10;
      fpsTxt.x += 15;
      fpsTxt.y += 15;
      memTxt.x += 15;
      memTxt.y += 30;
    }
    else
    {
      if (children.contains(displayBG)) removeChild(displayBG);
      if (children.contains(fpsTxt)) removeChild(fpsTxt);
      if (children.contains(memTxt)) removeChild(memTxt);
    }

    return value;
  }

  private var displayBG:Bitmap;
  private var fpsTxt:Text;
  private var memTxt:Text;

  public var peakMem:Float;

  public function new(fps:Bool = true)
  {
    super();

    this.show = fps;
  }

  override function sync(ctx:RenderContext):Void
  {
    if (fpsTxt != null && memTxt != null && displayBG != null && children.contains(displayBG) && children.contains(fpsTxt) && children.contains(memTxt))
    {
      fpsTxt.text = 'FPS: ' + Std.string(Math.floor(1 / hxd.Timer.elapsedTime));
      var mem = MemoryUtil.getMemory();
      var noFormat = MemoryUtil.getMemory(null, false);
      if (noFormat.num > peakMem) peakMem = noFormat.num;
      var peak = MemoryUtil.getMemory(peakMem);
      var unit = MemoryUtil.getUnitShort(mem.unit);
      var peakUnit = MemoryUtil.getUnitShort(peak.unit);
      memTxt.text = 'MEM: ' + Std.string(mem.num) + ' $unit / ' + Std.string(peak.num) + ' $peakUnit';
    }

    super.sync(ctx);
  }
}
