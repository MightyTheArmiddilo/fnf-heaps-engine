package funkin.util;

import hl.Gc;

class MemoryUtil
{
  public static final units:Map<Int, SizeUnit> = [0 => Byte, 3 => Kilobyte, 6 => Megabyte, 9 => Gigabyte, 12 => Terabyte];

  public static final unitDiv:Map<SizeUnit, Float> = [
    Byte => 1,
    Kilobyte => 1000,
    Megabyte => 1000000,
    Gigabyte => 1000000000,
    Terabyte => 1000000000000
  ];

  public static function getMemory(?mem:Float, format:Bool = true):MemoryData
  {
    var m = mem ?? Gc.stats().currentMemory;
    var u = getUnit(Math.floor(MathUtil.log10(m)));
    var formatted = format ? Math.floor(m / (unitDiv[u] / 10)) / 10 : m;
    return {
      unit: u,
      num: formatted
    };
  }

  public static function getUnit(placement:Int):SizeUnit
  {
    var curU:SizeUnit = Byte;

    var arr = [for (i => _ in units) i];
    arr.sort((a, b) -> {
      if (a > b) return 1;
      if (b > a) return -1;

      return 0;
    });

    for (n in arr)
    {
      if (placement < n) break;

      curU = units[n];
    }

    return curU;
  }

  public static function getUnitShort(unit:SizeUnit):String
  {
    return switch (unit)
    {
      case Byte: 'B';
      case Kilobyte: 'KB';
      case Megabyte: 'MB';
      case Gigabyte: 'GB';
      case Terabyte: 'TB';
    }
  }
}

typedef MemoryData =
{
  var unit:SizeUnit;
  var num:Float;
}

enum SizeUnit
{
  Byte;
  Kilobyte;
  Megabyte;
  Gigabyte;
  Terabyte;
}
