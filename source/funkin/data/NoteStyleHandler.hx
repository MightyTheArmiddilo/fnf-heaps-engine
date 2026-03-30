package funkin.data;

import hxd.res.Any as RAny;
import funkin.util.AssetUtil;
import haxe.Json;
import funkin.game.notes.notestyles.NoteStyle;

class NoteStyleHandler
{
  public static final noteStyles:Map<String, NoteStyle> = [];

  public static function initialize():Void
  {
    var jsons = AssetUtil.getFilesInDir('game/notestyles', function(res:RAny) {
      return res.entry.extension == 'json';
    });

    for (json in jsons)
    {
      var id = json.entry.name.substring(0, json.entry.name.length - (json.entry.extension.length + 1));
      var data = Json.parse(json.toText());

      // maybe this is why json2object exists...
      var finalData:NoteStyleData =
        {
          version: data.version,
          name: data.name,
          author: data.author,
          pixel: data.pixel ?? false,
          assets:
            {
              strum:
                {
                  assetPath: data.assets.strum.assetPath,
                  scale: data.assets.strum.scale ?? [1., 1.],
                  offsets: data.assets.strum.offsets ?? [0., 0.],
                  data:
                    {
                      left:
                        {
                          idle:
                            {
                              prefix: data.assets.strum.data.left.idle.prefix,
                              offsets: data.assets.strum.data.left.idle.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.left.idle.loop ?? false,
                              flip: data.assets.strum.data.left.idle.flip ?? [false, false],
                              frameRate: data.assets.strum.data.left.idle.frameRate ?? 24,
                              indices: data.assets.strum.data.left.idle.indices,
                              animType: data.assets.strum.data.left.idle.animType ?? 'labels',
                              renderType: data.assets.strum.data.left.idle.renderType ?? 'sparrow'
                            },
                          press:
                            {
                              prefix: data.assets.strum.data.left.press.prefix,
                              offsets: data.assets.strum.data.left.press.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.left.press.loop ?? false,
                              flip: data.assets.strum.data.left.press.flip ?? [false, false],
                              frameRate: data.assets.strum.data.left.press.frameRate ?? 24,
                              indices: data.assets.strum.data.left.press.indices,
                              animType: data.assets.strum.data.left.press.animType ?? 'labels',
                              renderType: data.assets.strum.data.left.press.renderType ?? 'sparrow'
                            },
                          confirm:
                            {
                              prefix: data.assets.strum.data.left.confirm.prefix,
                              offsets: data.assets.strum.data.left.confirm.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.left.confirm.loop ?? false,
                              flip: data.assets.strum.data.left.confirm.flip ?? [false, false],
                              frameRate: data.assets.strum.data.left.confirm.frameRate ?? 24,
                              indices: data.assets.strum.data.left.confirm.indices,
                              animType: data.assets.strum.data.left.confirm.animType ?? 'labels',
                              renderType: data.assets.strum.data.left.confirm.renderType ?? 'sparrow'
                            },
                          confirmHold:
                            {
                              prefix: data.assets.strum.data.left.confirmHold.prefix,
                              offsets: data.assets.strum.data.left.confirmHold.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.left.confirmHold.loop ?? true,
                              flip: data.assets.strum.data.left.confirmHold.flip ?? [false, false],
                              frameRate: data.assets.strum.data.left.confirmHold.frameRate ?? 24,
                              indices: data.assets.strum.data.left.confirmHold.indices,
                              animType: data.assets.strum.data.left.confirmHold.animType ?? 'labels',
                              renderType: data.assets.strum.data.left.confirmHold.renderType ?? 'sparrow'
                            }
                        },
                      down:
                        {
                          idle:
                            {
                              prefix: data.assets.strum.data.down.idle.prefix,
                              offsets: data.assets.strum.data.down.idle.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.down.idle.loop ?? false,
                              flip: data.assets.strum.data.down.idle.flip ?? [false, false],
                              frameRate: data.assets.strum.data.down.idle.frameRate ?? 24,
                              indices: data.assets.strum.data.down.idle.indices,
                              animType: data.assets.strum.data.down.idle.animType ?? 'labels',
                              renderType: data.assets.strum.data.down.idle.renderType ?? 'sparrow'
                            },
                          press:
                            {
                              prefix: data.assets.strum.data.down.press.prefix,
                              offsets: data.assets.strum.data.down.press.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.down.press.loop ?? false,
                              flip: data.assets.strum.data.down.press.flip ?? [false, false],
                              frameRate: data.assets.strum.data.down.press.frameRate ?? 24,
                              indices: data.assets.strum.data.down.press.indices,
                              animType: data.assets.strum.data.down.press.animType ?? 'labels',
                              renderType: data.assets.strum.data.down.press.renderType ?? 'sparrow'
                            },
                          confirm:
                            {
                              prefix: data.assets.strum.data.down.confirm.prefix,
                              offsets: data.assets.strum.data.down.confirm.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.down.confirm.loop ?? false,
                              flip: data.assets.strum.data.down.confirm.flip ?? [false, false],
                              frameRate: data.assets.strum.data.down.confirm.frameRate ?? 24,
                              indices: data.assets.strum.data.down.confirm.indices,
                              animType: data.assets.strum.data.down.confirm.animType ?? 'labels',
                              renderType: data.assets.strum.data.down.confirm.renderType ?? 'sparrow'
                            },
                          confirmHold:
                            {
                              prefix: data.assets.strum.data.down.confirmHold.prefix,
                              offsets: data.assets.strum.data.down.confirmHold.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.down.confirmHold.loop ?? true,
                              flip: data.assets.strum.data.down.confirmHold.flip ?? [false, false],
                              frameRate: data.assets.strum.data.down.confirmHold.frameRate ?? 24,
                              indices: data.assets.strum.data.down.confirmHold.indices,
                              animType: data.assets.strum.data.down.confirmHold.animType ?? 'labels',
                              renderType: data.assets.strum.data.down.confirmHold.renderType ?? 'sparrow'
                            }
                        },
                      up:
                        {
                          idle:
                            {
                              prefix: data.assets.strum.data.up.idle.prefix,
                              offsets: data.assets.strum.data.up.idle.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.up.idle.loop ?? false,
                              flip: data.assets.strum.data.up.idle.flip ?? [false, false],
                              frameRate: data.assets.strum.data.up.idle.frameRate ?? 24,
                              indices: data.assets.strum.data.up.idle.indices,
                              animType: data.assets.strum.data.up.idle.animType ?? 'labels',
                              renderType: data.assets.strum.data.up.idle.renderType ?? 'sparrow'
                            },
                          press:
                            {
                              prefix: data.assets.strum.data.up.press.prefix,
                              offsets: data.assets.strum.data.up.press.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.up.press.loop ?? false,
                              flip: data.assets.strum.data.up.press.flip ?? [false, false],
                              frameRate: data.assets.strum.data.up.press.frameRate ?? 24,
                              indices: data.assets.strum.data.up.press.indices,
                              animType: data.assets.strum.data.up.press.animType ?? 'labels',
                              renderType: data.assets.strum.data.up.press.renderType ?? 'sparrow'
                            },
                          confirm:
                            {
                              prefix: data.assets.strum.data.up.confirm.prefix,
                              offsets: data.assets.strum.data.up.confirm.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.up.confirm.loop ?? false,
                              flip: data.assets.strum.data.up.confirm.flip ?? [false, false],
                              frameRate: data.assets.strum.data.up.confirm.frameRate ?? 24,
                              indices: data.assets.strum.data.up.confirm.indices,
                              animType: data.assets.strum.data.up.confirm.animType ?? 'labels',
                              renderType: data.assets.strum.data.up.confirm.renderType ?? 'sparrow'
                            },
                          confirmHold:
                            {
                              prefix: data.assets.strum.data.up.confirmHold.prefix,
                              offsets: data.assets.strum.data.up.confirmHold.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.up.confirmHold.loop ?? true,
                              flip: data.assets.strum.data.up.confirmHold.flip ?? [false, false],
                              frameRate: data.assets.strum.data.up.confirmHold.frameRate ?? 24,
                              indices: data.assets.strum.data.up.confirmHold.indices,
                              animType: data.assets.strum.data.up.confirmHold.animType ?? 'labels',
                              renderType: data.assets.strum.data.up.confirmHold.renderType ?? 'sparrow'
                            }
                        },
                      right:
                        {
                          idle:
                            {
                              prefix: data.assets.strum.data.right.idle.prefix,
                              offsets: data.assets.strum.data.right.idle.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.right.idle.loop ?? false,
                              flip: data.assets.strum.data.right.idle.flip ?? [false, false],
                              frameRate: data.assets.strum.data.right.idle.frameRate ?? 24,
                              indices: data.assets.strum.data.right.idle.indices,
                              animType: data.assets.strum.data.right.idle.animType ?? 'labels',
                              renderType: data.assets.strum.data.right.idle.renderType ?? 'sparrow'
                            },
                          press:
                            {
                              prefix: data.assets.strum.data.right.press.prefix,
                              offsets: data.assets.strum.data.right.press.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.right.press.loop ?? false,
                              flip: data.assets.strum.data.right.press.flip ?? [false, false],
                              frameRate: data.assets.strum.data.right.press.frameRate ?? 24,
                              indices: data.assets.strum.data.right.press.indices,
                              animType: data.assets.strum.data.right.press.animType ?? 'labels',
                              renderType: data.assets.strum.data.right.press.renderType ?? 'sparrow'
                            },
                          confirm:
                            {
                              prefix: data.assets.strum.data.right.confirm.prefix,
                              offsets: data.assets.strum.data.right.confirm.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.right.confirm.loop ?? false,
                              flip: data.assets.strum.data.right.confirm.flip ?? [false, false],
                              frameRate: data.assets.strum.data.right.confirm.frameRate ?? 24,
                              indices: data.assets.strum.data.right.confirm.indices,
                              animType: data.assets.strum.data.right.confirm.animType ?? 'labels',
                              renderType: data.assets.strum.data.right.confirm.renderType ?? 'sparrow'
                            },
                          confirmHold:
                            {
                              prefix: data.assets.strum.data.right.confirmHold.prefix,
                              offsets: data.assets.strum.data.right.confirmHold.offsets ?? [0., 0.],
                              loop: data.assets.strum.data.right.confirmHold.loop ?? true,
                              flip: data.assets.strum.data.right.confirmHold.flip ?? [false, false],
                              frameRate: data.assets.strum.data.right.confirmHold.frameRate ?? 24,
                              indices: data.assets.strum.data.right.confirmHold.indices,
                              animType: data.assets.strum.data.right.confirmHold.animType ?? 'labels',
                              renderType: data.assets.strum.data.right.confirmHold.renderType ?? 'sparrow'
                            }
                        },
                    }
                }
            }
        };

      noteStyles[id] = new NoteStyle(id, finalData);
    }
  }
}
