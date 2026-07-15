package;

using util.AnsiUtil;

class Compile
{
  static var buildArgs:Array<String> = [];

  static final releaseArgs:Array<String> = ['r', 'release', '-r', '--r', '-release', '--release'];
  static final debugArgs:Array<String> = ['d', 'debug', '-d', '--d', '-debug', '--debug'];
  static inline final buildDefault:String = 'd';
  static var isDebug:Bool;

  static final launchArgs:Array<String> = ['l', 'launch', '-l', '--l', '-launch', '--launch'];
  static final quietArgs:Array<String> = ['q', 'quiet', '-q', '--q', '-quiet', '--quiet'];
  static inline final launchDefault:String = 'l';
  static var shouldLaunch:Bool;

  static final compileArgs:Array<String> = ['c', 'compile', '-c', '--c', '-compile', '--compile'];
  static final skipArgs:Array<String> = ['s', 'skip', '-s', '--s', '-skip', '--skip'];
  static inline final compileDefault:String = 'c';
  static var shouldCompile:Bool;

  static final REDIRECT_ASSETS:Bool = true;

  static function main():Void
  {
    var passedArgs = Sys.args();

    if (releaseArgs.contains(passedArgs[0])) passedArgs[0] = 'r';
    if (debugArgs.contains(passedArgs[0])) passedArgs[0] = 'd';
    if (passedArgs[0] == null) passedArgs[0] = buildDefault;
    isDebug = passedArgs[0] == 'd';

    if (launchArgs.contains(passedArgs[1])) passedArgs[1] = 'l';
    if (quietArgs.contains(passedArgs[1])) passedArgs[1] = 'q';
    if (passedArgs[1] == null) passedArgs[1] = launchDefault;
    shouldLaunch = passedArgs[1] == 'l';

    if (compileArgs.contains(passedArgs[2])) passedArgs[2] = 'c';
    if (skipArgs.contains(passedArgs[2])) passedArgs[2] = 's';
    if (passedArgs[2] == null) passedArgs[2] = compileDefault;
    shouldCompile = passedArgs[2] == 'c';

    if (shouldCompile)
    {
      addHaxeLibrary('heaps');

      addHaxeLibrary('hlsdl');

      addHaxeLibrary('hlopenal');

      setHaxeMain('Main');

      var compilePath = isDebug ? 'export/windows/debug/bin/Main.hl' : 'export/windows/release/c/Main.c';
      setHLCompilePath(compilePath);

      setSourcePath('source');

      addHaxeMacro('funkin.macro.Prebuild', 'run');
      addHaxeMacro('funkin.macro.Postbuild', 'run');

      if (isDebug) setHaxeDefine('debug');
      else
        setHaxeDefine('hlgen.makefile', 'hxcpp');

      setHaxeDefine('multidriver');

      setHaxeDefine('resourcesPath', 'assets');

      if (REDIRECT_ASSETS) setHaxeDefine('REDIRECT_ASSETS');

      setHaxeDefine('windowSize', '1280x720');

      setHaxeDefine('windowTitle', 'Friday Night Funkin\': Heaps Engine');

      /*var i = 0;
        var args = [];
        while (i < buildArgs.length / 2)
        {
          args.push(buildArgs[i * 2] + ' ' + buildArgs[i * 2 + 1]);
          i++;
        }

        trace(args.join('\n')); */

      if (isDebug) info('Compiling debug build...');
      else
        info('Compiling release build...');

      var code = Sys.command('haxe', buildArgs);

      if (code == 0) info('Done!');
      else
      {
        error('There was an error with compiling!');
        return;
      }
    }

    if (shouldLaunch)
    {
      info('Launching game...');
      if (isDebug) Sys.command('hl', ['export/windows/debug/bin/Main.hl']);
      else
        Sys.command('export\\windows\\release\\bin\\Funkin.exe');
    }
  }

  static function addHaxeParam(param:String):Void
  {
    buildArgs.push(param);
  }

  static function addHaxeLibrary(library:String):Void
  {
    addHaxeParam('-lib');
    addHaxeParam(library);
  }

  static function addHaxeMacro(cls:String, func:String):Void
  {
    addHaxeParam('--macro');
    addHaxeParam('$cls.$func()');
  }

  static function setHaxeDefine(def:String, ?value:String):Void
  {
    addHaxeParam('-D');
    var define = def + (value != null ? '=$value' : '');
    addHaxeParam(define);
  }

  static function setHaxeMain(main:String):Void
  {
    addHaxeParam('-main');
    addHaxeParam(main);
  }

  static function setHLCompilePath(path:String):Void
  {
    addHaxeParam('-hl');
    addHaxeParam(path);
  }

  static function setSourcePath(path:String):Void
  {
    addHaxeParam('-cp');
    addHaxeParam(path);
  }

  static function info(message:String):Void
  {
    Sys.println(' INFO '.info() + ' $message');
  }

  static function error(message:String):Void
  {
    Sys.println(' ERROR '.error() + ' $message');
  }
}
