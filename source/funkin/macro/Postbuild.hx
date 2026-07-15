package funkin.macro;

import haxe.macro.Context;
import sys.io.File;
import sys.FileSystem;

using StringTools;
using funkin.util.AnsiUtil;

class Postbuild
{
  #if macro
  static var assetsPath = 'assets';
  static var rawPath = 'export/windows/release/c';
  static var releasePath = 'export/windows/release/bin';
  static var debugPath = 'export/windows/debug/bin';
  static var exeName = 'Funkin';

  static var fileCount = 0;
  static var folderCount = 0;

  static function run():Void
  {
    Context.onAfterGenerate(postbuild);
  }

  static function postbuild():Void
  {
    copyFiles();

    printBuildTime();
  }

  static function printBuildTime():Void
  {
    var end = Sys.time();
    if (!FileSystem.exists('.build_time')) return;

    var input = File.read('.build_time');
    var start:Float = input.readDouble();
    input.close();

    FileSystem.deleteFile('.build_time');

    Sys.println(' INFO '.info() + ' Build took: ${formatTime(end - start)}');
  }

  // taken from Funkin's source
  static function formatTime(time:Float, decimals:Int = 1):String
  {
    var units = [
      {name: 'day', secs: 86400},
      {name: 'hour', secs: 3600},
      {name: 'minute', secs: 60},
      {name: 'second', secs: 1}
    ];

    var parts:Array<String> = [];
    var remaining:Float = time;
    var factor = Math.pow(10, decimals); // compute once because the old code was computing it twice.

    for (u in units)
    {
      var value:Float = (u.name == 'second') ? Math.round(remaining * factor) / factor : Math.floor(remaining / u.secs);

      if (u.name != 'second') remaining %= u.secs;

      if (value > 0 || (u.name == 'second' && parts.length == 0)) parts.push('${value} ${u.name}${value == 1 ? "" : "s"}');
    }

    return parts.join(' ');
  }

  static function copyFiles():Void
  {
    Sys.println(' INFO '.info() + ' Copying files...');

    var exportPath = #if debug debugPath; #else releasePath; #end

    if (!FileSystem.exists(exportPath)) FileSystem.createDirectory(exportPath);

    #if !debug
    File.copy('$rawPath/Main.exe', '$exportPath/$exeName.exe');
    fileCount += 1;
    #end

    if (FileSystem.exists('$exportPath/$assetsPath')) deleteRecursively('$exportPath/$assetsPath');
    FileSystem.createDirectory('$exportPath/$assetsPath');

    copyRecursively(assetsPath, '$exportPath/$assetsPath');

    Sys.println(' INFO '.info() + ' Copied $fileCount files and $folderCount folders!');
  }

  static function deleteRecursively(target:String):Void
  {
    if (FileSystem.isDirectory(target))
    {
      if (!FileSystem.exists(target)) return;
      for (item in FileSystem.readDirectory(target))
        deleteRecursively('$target/$item');
      FileSystem.deleteDirectory(target);
    }
    else
    {
      FileSystem.deleteFile(target);
    }
  }

  static function copyRecursively(src:String, dst:String):Void
  {
    if (FileSystem.isDirectory(src))
    {
      if (!FileSystem.exists(dst)) FileSystem.createDirectory(dst);
      for (item in FileSystem.readDirectory(src))
        copyRecursively('$src/$item', '$dst/$item');
      folderCount += 1;
    }
    else
    {
      File.copy(src, dst);
      fileCount += 1;
    }
  }
  #end
}
