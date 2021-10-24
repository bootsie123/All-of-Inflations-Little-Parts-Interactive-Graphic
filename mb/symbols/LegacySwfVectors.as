// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.LegacySwfVectors

package mb.symbols
{
    import flash.display.Loader;
    import flash.display.MovieClip;
    import mb.projections.IGeoProjection;
    import mb.projections.Projection;
    import flash.events.Event;
    import flash.geom.Point;
    import mb.projections.GeographicProjection;
    import flash.net.URLRequest;
    import flash.display.*;
    import flash.events.*;
    import mb.projections.*;

    public class LegacySwfVectors extends RawVectors 
    {

        public static const PROJECTED:String = "proj";
        public static const PACKED:String = "packed";

        private var projShapeBB_arr:Array;
        public var cellTable_arr:Array;
        private var _loader:Loader;
        private var _mc:MovieClip;
        private var _shpType:int;
        public var bounds_arr:Array;
        private var swfVersion:Number;

        private var _format:String = PACKED;//"packed"
        private var shapesArr:Array = null;
        private var numShapes:int = 0;
        private var packedBB_arr:Array = null;
        private var _projBB:Array = null;
        private var haveBounds:Boolean = false;
        private var _mPack:Number = 1;
        private var _bxPack:Number = 0;
        private var _byPack:Number = 0;
        public var _mUnpack:Number = 1;
        public var _bxUnpack:Number = 0;
        public var _byUnpack:Number = 0;
        private var _importProj:IGeoProjection = null;

        public function LegacySwfVectors(_arg_1:String, _arg_2:Projection)
        {
            super(_arg_1, _arg_2, 0);
        }

        private function handleLoad(_arg_1:Event):*
        {
            _mc = MovieClip(_loader.content);
            notifyReady();
        }

        public function extractProjectedShapes(_arg_1:IGeoProjection):Array
        {
            var _local_2:Object;
            var _local_3:*;
            var _local_4:int;
            var _local_5:Point;
            var _local_6:Point;
            _local_2 = _mc.obj;
            if (!_local_2)
            {
                return ([]);
            };
            if (_local_2.version != 0.4)
            {
                return ([]);
            };
            _project = false;
            _reproject = false;
            _importProj = _arg_1;
            if (((!(_nativeProj)) || (_nativeProj.name == GeographicProjection.GEOGRAPHIC)))
            {
                _project = true;
            }
            else
            {
                if (!_nativeProj.compare(_arg_1))
                {
                    _reproject = true;
                };
            };
            numShapes = _local_2.shapes.length;
            _shpType = _local_2.shp_type;
            packedBB_arr = [_local_2.minx, _local_2.miny, _local_2.maxx, _local_2.maxy];
            _mPack = _local_2.rescale_m;
            _bxPack = _local_2.rescale_bx;
            _byPack = _local_2.rescale_by;
            _mUnpack = (1 / _mPack);
            _bxUnpack = (-(_bxPack) / _mPack);
            _byUnpack = (-(_byPack) / _mPack);
            _projBB = [];
            _projBB[0] = ((packedBB_arr[0] * _mUnpack) + _bxUnpack);
            _projBB[1] = ((packedBB_arr[1] * _mUnpack) + _byUnpack);
            _projBB[2] = ((packedBB_arr[2] * _mUnpack) + _bxUnpack);
            _projBB[3] = ((packedBB_arr[3] * _mUnpack) + _byUnpack);
            if (((_project) || (_reproject)))
            {
                if (_project)
                {
                    _local_5 = _importProj.project(_projBB[1], _projBB[0]);
                    _local_6 = _importProj.project(_projBB[3], _projBB[2]);
                }
                else
                {
                    if (_reproject)
                    {
                        _local_5 = _importProj.reproject(_projBB[1], _projBB[0], _nativeProj);
                        _local_6 = _importProj.reproject(_projBB[3], _projBB[2], _nativeProj);
                    };
                };
                if (_local_5.x < _local_6.x)
                {
                    _projBB[0] = _local_5.x;
                    _projBB[2] = _local_6.x;
                }
                else
                {
                    _projBB[0] = _local_6.x;
                    _projBB[2] = _local_5.x;
                };
                if (_local_5.y < _local_6.y)
                {
                    _projBB[1] = _local_5.y;
                    _projBB[3] = _local_6.y;
                }
                else
                {
                    _projBB[1] = _local_6.y;
                    _projBB[3] = _local_5.y;
                };
            };
            _local_3 = new Array(numShapes);
            _local_4 = 0;
            while (_local_4 < numShapes)
            {
                _local_3[_local_4] = importShapeParts4(_local_4, _local_2.shapes[_local_4]);
                _local_4++;
            };
            return (_local_3);
        }

        override protected function load():*
        {
            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.INIT, handleLoad);
            _loader.load(new URLRequest(_url));
        }

        private function importShapeParts4(_arg_1:int, _arg_2:Array):ShapeVector
        {
            var _local_3:ShapeVector;
            var _local_4:Array;
            var _local_5:Number;
            var _local_6:int;
            var _local_7:Array;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:int;
            var _local_13:Array;
            var _local_14:Array;
            var _local_15:int;
            var _local_16:Array;
            var _local_17:Array;
            var _local_18:int;
            var _local_19:ArcVertexSet;
            var _local_20:PartVertexSet;
            var _local_21:Number;
            var _local_22:Number;
            var _local_23:Point;
            _local_3 = new ShapeVector(_arg_1);
            if (!_arg_2)
            {
                return (_local_3);
            };
            _local_4 = [];
            _local_5 = _arg_2.length;
            if ((_local_5 % 2) == 1)
            {
                return (_local_3);
            };
            _local_6 = int((_local_5 / 2));
            _local_7 = new Array(_local_6);
            _local_12 = 0;
            while (_local_12 < _local_6)
            {
                _local_13 = _arg_2[(_local_12 * 2)];
                _local_14 = _arg_2[((_local_12 * 2) + 1)];
                _local_15 = _local_13.length;
                _local_16 = new Array(_local_15);
                _local_17 = new Array(_local_15);
                if (_local_15 != 0)
                {
                    _local_18 = 0;
                    while (_local_18 < _local_15)
                    {
                        _local_21 = ((_local_13[_local_18] * _mUnpack) + _bxUnpack);
                        _local_22 = ((_local_14[_local_18] * _mUnpack) + _byUnpack);
                        if (_project)
                        {
                            _local_23 = _importProj.project(_local_22, _local_21);
                            _local_21 = _local_23.x;
                            _local_22 = _local_23.y;
                        }
                        else
                        {
                            if (_reproject)
                            {
                                _local_23 = _importProj.reproject(_local_21, _local_22, _nativeProj);
                                _local_21 = _local_23.x;
                                _local_22 = _local_23.y;
                            };
                        };
                        _local_16[_local_18] = _local_21;
                        _local_17[_local_18] = _local_22;
                        if (_local_18 == 0)
                        {
                            _local_8 = (_local_9 = _local_21);
                            _local_10 = (_local_11 = _local_22);
                        }
                        else
                        {
                            if (_local_21 < _local_8)
                            {
                                _local_8 = _local_21;
                            }
                            else
                            {
                                if (_local_21 > _local_9)
                                {
                                    _local_9 = _local_21;
                                };
                            };
                            if (_local_22 < _local_10)
                            {
                                _local_10 = _local_22;
                            }
                            else
                            {
                                if (_local_22 > _local_11)
                                {
                                    _local_11 = _local_22;
                                };
                            };
                        };
                        _local_18++;
                    };
                    if (_shpType == 5)
                    {
                        _local_16.push(_local_16[0]);
                        _local_17.push(_local_17[0]);
                    };
                    _local_19 = new ArcVertexSet(_local_16, _local_17, ArcVertexSet.FORWARD);
                    _local_19.setBounds(_local_8, _local_11, _local_9, _local_10);
                    _local_20 = new PartVertexSet();
                    _local_20.addArcVertices(_local_19);
                    _local_3.addPartData(_local_20);
                };
                _local_12++;
            };
            return (_local_3);
        }


    }
}//package mb.symbols

