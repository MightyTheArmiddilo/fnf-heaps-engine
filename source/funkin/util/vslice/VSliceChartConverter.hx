package funkin.util.vslice;

import haxe.Json;
import funkin.data.SongData.SongChartData;

/**
 * A member class of the chart converter family that
 * converts V-Slice charts to our charts.
 */
class VSliceChartConverter
{
  public static function convertChart(contents:String):SongChartData
  {
    var vChart = parseChart(contents);

    var result =
      {
        scrollSpeed: 3.2,
        notes: []
      };

    for (note in vChart.notes['hard'])
    {
      result.notes.push({time: note.time, dir: note.data % 4});
    }

    return result;
  }

  public static function parseChart(contents:String):VSliceChartData
  {
    var d = Json.parse(contents);

    var c = new VSliceChartData([]);

    for (f in Reflect.fields(d.notes))
    {
      var arr:Array<Dynamic> = Reflect.field(d.notes, f);
      c.notes[f] = [
        for (n in arr)
        {
          var r = new VSliceNoteData(n.time ?? n.t);
          r.data = n.data ?? n.d;
          r;
        }
      ];
    }

    return c;
  }
}

class VSliceChartData
{
  public var notes:Map<String, Array<VSliceNoteData>>;

  public function new(notes:Map<String, Array<VSliceNoteData>>)
  {
    this.notes = notes;
  }
}

class VSliceNoteData
{
  public var time:Float;

  public var data:Int;

  public function new(time:Float)
  {
    this.time = time;
  }
}
