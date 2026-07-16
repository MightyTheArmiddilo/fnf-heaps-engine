package funkin.macro;

@:build(funkin.macro.AppIconBuilder.build())
class AppIcon
{
  static var icon:haxe.io.Bytes;

  public static function getAppIcon():hxd.res.Any
  {
    return hxd.res.Any.fromBytes('icon64.png', icon);
  }
}
