package funkin.util;

import hxd.Res;
import hxd.res.Any as RAny;

class AssetUtil
{
  public static function getFilesInDir(directory:String = '', ?checker:RAny->Bool):Array<RAny>
  {
    var dir = Res.loader.dir(directory);
    if (dir == null) return [];
    var items:Array<RAny> = [];

    for (item in dir)
    {
      /*trace(item.entry.path);
        trace(item.entry.name);
        trace(item.entry.isDirectory);
        if (checker != null) trace(checker(item)); */

      if (checker == null) items.push(item);
      else if (checker(item)) items.push(item);

      if (item.entry.isDirectory) items = items.concat(getFilesInDir(item.entry.path, checker));
    }

    return items;
  }
}
