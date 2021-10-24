// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.LayerManager

package mb
{
    import flash.display.Sprite;

    public class LayerManager 
    {

        private var _overlayCanvas:Sprite;
        private var _labelContainer:Sprite;
        private var _baselayerContainer:Sprite;
        private var _overlayContainer:Sprite;
        private var _map:MapInfo;
        private var shapeLayersArr:Array;

        public function LayerManager(_arg_1:Sprite, _arg_2:MapInfo)
        {
            _map = _arg_2;
            shapeLayersArr = [];
            _baselayerContainer = Util.createSprite(_arg_1);
            _overlayContainer = Util.createSprite(_arg_1);
            _labelContainer = Util.createSprite(_arg_1);
        }

        public function reframeLayers():*
        {
            var _local_1:String;
            var _local_2:MapLayer;
            for (_local_1 in shapeLayersArr)
            {
                _local_2 = shapeLayersArr[_local_1];
                if (((_local_2.ready) && (!(_local_2.hidden))))
                {
                    _local_2.reposition();
                };
            };
        }

        public function refreshLayers():*
        {
            var _local_1:String;
            var _local_2:VectorLayer;
            for (_local_1 in shapeLayersArr)
            {
                _local_2 = shapeLayersArr[_local_1];
                if (((_local_2.ready) && (!(_local_2.hidden))))
                {
                    _local_2.refresh();
                };
            };
        }

        public function repositionLayers():*
        {
            var _local_1:String;
            var _local_2:MapLayer;
            for (_local_1 in shapeLayersArr)
            {
                _local_2 = shapeLayersArr[_local_1];
                if (((_local_2.ready) && (!(_local_2.hidden))))
                {
                    _local_2.rescale();
                };
            };
        }

        public function setLayerVisibility():*
        {
            var _local_1:Number;
            var _local_2:String;
            var _local_3:MapLayer;
            var _local_4:Boolean;
            _local_1 = _map.navigation.scale;
            for (_local_2 in shapeLayersArr)
            {
                _local_3 = shapeLayersArr[_local_2];
                _local_4 = _local_3.testScale(_local_1);
                if (!_local_4)
                {
                    _local_3.hide();
                }
                else
                {
                    if (((!(_local_3.visible)) && (_local_4)))
                    {
                        _local_3.show();
                    };
                };
            };
        }

        public function addLayer(_arg_1:MapLayer):*
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:Sprite;
            _local_2 = _arg_1.family;
            _local_3 = _arg_1.type;
            if (_local_3 == MapLayer.LABEL)
            {
                _local_4 = _labelContainer;
            }
            else
            {
                if (_local_3 == MapLayer.OVERLAY)
                {
                    _local_4 = _overlayContainer;
                }
                else
                {
                    if (_local_2 == MapLayer.VECTOR)
                    {
                        _local_4 = _baselayerContainer;
                    }
                    else
                    {
                        if (((_local_2 == MapLayer.RASTER) || (_local_2 == MapLayer.IMAGE)))
                        {
                            _local_4 = _baselayerContainer;
                        }
                        else
                        {
                            return;
                        };
                    };
                };
            };
            shapeLayersArr.push(_arg_1);
            _arg_1.place(_map, _local_4);
        }


    }
}//package mb

