package;

/**
 * This class is what the game enters through, it sets a few things up.
 */
class Main
{
  static final startingWidth:Int = 1280;

  static final startingHeight:Int = 720;

  static final title:String = 'Friday Night Funkin\': Heaps Engine';

  static final startingScene:Class<h2d.Scene> = funkin.game.FunkinScene;

  static function main():Void
  {
    trace('startup');

    var startingApp = funkin.Host.newContext(new funkin.Game(startingScene));
    startingApp.win.resize(startingWidth, startingHeight);
    startingApp.win.title = title;
  }
}
