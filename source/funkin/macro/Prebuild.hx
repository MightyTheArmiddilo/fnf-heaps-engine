package funkin.macro;

import haxe.macro.Context;
import sys.io.File;

using StringTools;
using funkin.util.AnsiUtil;

class Prebuild
{
  #if macro
  static function run():Void
  {
    prebuild();
  }

  static function prebuild():Void
  {
    saveBuildTime();
  }

  static function saveBuildTime():Void
  {
    var out = File.write('.build_time');
    var time = Sys.time();
    out.writeDouble(time);
    out.close();
  }
  #end
}
