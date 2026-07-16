package funkin.data;

import hxd.res.Any as RAny;
import funkin.util.AssetUtil;
import haxe.Json;
import funkin.game.notes.notestyles.NoteStyle;

/**
 * A handler for note styles.
 */
class NoteStyleHandler
{
  public static final noteStyles:Map<String, NoteStyle> = [];

  public static function initialize():Void
  {
    for (noteStyle in noteStyles)
      noteStyle = null;
    noteStyles.clear();

    var jsons = AssetUtil.getFilesInDir('game/notestyles', function(res:RAny) {
      return res.entry.extension == 'json';
    });

    for (json in jsons)
    {
      var id = json.entry.name.substring(0, json.entry.name.length - (json.entry.extension.length + 1));
      var data = Json.parse(json.toText());

      noteStyles[id] = new NoteStyle(id, data);
    }
  }
}
