package funkin;

import hxd.App;
import hxd.impl.AppContext;

/**
 * A class for managing general game info.
 */
@:access(hxd.impl.AppContext)
class Global
{
  /**
   * An array of all existing AppContexts.
   */
  public static var contexts(get, null):Array<AppContext>;

  static function get_contexts():Array<AppContext>
  {
    return AppContext.contexts;
  }

  public static function newContext(app:App):AppContext
  {
    return new AppContext(app);
  }
}
