package funkin.data;

typedef SongChartData =
{
  var ?scrollSpeed:Float;

  var notes:Array<SongNoteData>;
}

typedef SongNoteData =
{
  var time:Float;

  var dir:Int;
}
