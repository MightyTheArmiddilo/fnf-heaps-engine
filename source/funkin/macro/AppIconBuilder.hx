package funkin.macro;

import haxe.macro.Context;
import haxe.macro.Expr;

class AppIconBuilder
{
  public static macro function build():Array<Field>
  {
    var fields = Context.getBuildFields();

    for (f in fields)
    {
      if (f.name == 'icon')
      {
        f.kind = FVar(macro :haxe.io.Bytes, macro sys.io.File.getBytes('icon64.png'));
      }
    }

    return fields;
  }
}
