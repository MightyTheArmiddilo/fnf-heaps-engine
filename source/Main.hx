package;

import hxd.res.Loader;
import hxd.fs.LocalFileSystem;
import funkin.Global;

using StringTools;
using funkin.util.AnsiUtil;

/**
 * This class is what the game enters through, it sets a few things up.
 */
class Main
{
  static final startingWidth:Int = 1280;

  static final startingHeight:Int = 720;

  static final title:String = 'Friday Night Funkin\': Heaps Engine';

  static final startingScene:Class<h2d.Scene> = funkin.InitScene;

  static function main():Void
  {
    trace(' KINETIC ENGINE '.bg_orange().bold() + ' Let\'s get funky!');

    #if REDIRECT_ASSETS
    setupFileSystem('../../../../assets');
    #else
    setupFileSystem('assets');
    #end

    var startingApp = Global.newContext(new funkin.Game(startingScene));
    startingApp.win.resize(startingWidth, startingHeight);
    @:privateAccess startingApp.win.window.center();
    startingApp.win.title = title;
    startingApp.win.vsync = false;

    trace('Initializing classes...');

    kinetic.ui.KineticUI.initialize();

    funkin.data.NoteStyleHandler.initialize();
  }

  /**
   * `resourcesPath` pointing to a non existent path makes compile die cuz embed,
   * so instead we do it like this, allowing for things like `REDIRECT_ASSETS`.
   * 
   * @param assetPath 
   */
  static function setupFileSystem(assetPath:String):Void
  {
    hxd.Res.loader = new Loader(new LocalFileSystem(assetPath, null));
  }
}
