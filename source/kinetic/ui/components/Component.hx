package kinetic.ui.components;

import h2d.Bitmap;

class Component extends Bitmap
{
  public function new(?parent:h2d.Object)
  {
    super(null, parent);
  }

  public function getMeta():ComponentData.ComponentExtraData
  {
    return {
      name: 'component',
      fields: []
    };
  }
}
