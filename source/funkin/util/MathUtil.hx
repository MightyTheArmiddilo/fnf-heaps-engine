package funkin.util;

class MathUtil
{
  public static final BASE_EULER_TO_BASE_TEN:Float = 0.434294481903;

  public static function log10(v:Float)
  {
    return Math.log(v) * BASE_EULER_TO_BASE_TEN;
  }
}
