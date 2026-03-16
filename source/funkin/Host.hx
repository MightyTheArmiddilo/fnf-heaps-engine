package funkin;

import hxd.App;
import hxd.impl.AppContext;

@:access(hxd.impl.AppContext)
class Host
{
  public static var contexts(get, null):Array<AppContext>;

  static function get_contexts():Array<AppContext>
  {
    return AppContext.contexts;
  }

  public static function newContext(app:App)
  {
    return new AppContext(app);
  }
}
