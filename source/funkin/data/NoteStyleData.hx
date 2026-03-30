package funkin.data;

import funkin.data.AnimationData.UnnamedAnimationData;

typedef NoteStyleData =
{
  var version:String;

  var name:String;

  var author:String;

  var ?pixel:Bool;

  var assets:NoteStyleAssetsData;
}

typedef NoteStyleAssetsData =
{
  var strum:NoteStyleAssetData<StrumAssetData>;
}

typedef NoteStyleAssetData<T> =
{
  var assetPath:String;

  var ?scale:Array<Float>;

  var ?offsets:Array<Float>;

  var data:T;
}

typedef StrumAssetData =
{
  var left:StrumNoteAssetData;
  var down:StrumNoteAssetData;
  var up:StrumNoteAssetData;
  var right:StrumNoteAssetData;
}

typedef StrumNoteAssetData =
{
  var idle:UnnamedAnimationData;
  var press:UnnamedAnimationData;
  var confirm:UnnamedAnimationData;
  var confirmHold:UnnamedAnimationData;
}
