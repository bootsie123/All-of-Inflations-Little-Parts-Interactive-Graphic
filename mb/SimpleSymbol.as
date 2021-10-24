// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.SimpleSymbol

package mb
{
    import flash.display.Sprite;
    import flash.display.*;

    public class SimpleSymbol 
    {

        private var symbol_mc:Sprite;
        private var ppoint:ProjectedPoint;
        private var easer:Easer;
        private var _id:int;
        private var parent_mc:Sprite;
        private var currColor:Number;
        private var ids_arr:Array;

        private var mineaserSize:Number = 5;
        private var useeaser:Boolean = true;
        private var growDuration:Number = 300;
        private var shrinkDuration:Number = 300;
        private var hideDuration:Number = 200;
        private var _baseSize:Number = 0;
        private var useHandCursor:Boolean = false;
        private var currValue:Number = 0;
        private var currSize:Number = 0;
        private var initialSize:Number = 1;
        public var _radius:Number = 0;
        public var xpos:Number = 0;
        public var ypos:Number = 0;

        public function SimpleSymbol(_arg_1:Sprite, _arg_2:String)
        {
            this.parent_mc = _arg_1;
            symbol_mc = Util.attachLibrarySprite(_arg_2, _arg_1);
            if (!symbol_mc)
            {
                return;
            };
            if (symbol_mc.width != initialSize)
            {
                symbol_mc.width = initialSize;
                symbol_mc.height = initialSize;
                currSize = initialSize;
            };
            easer = new Easer(symbol_mc);
            easer.setCallback(this, handleeaser, Easer.EASE);
        }

        public function get pp():ProjectedPoint
        {
            return (ppoint);
        }

        public function setSize(_arg_1:Number):*
        {
            symbol_mc.width = _arg_1;
            symbol_mc.height = _arg_1;
            currSize = _arg_1;
            _radius = (_arg_1 / 2);
        }

        public function show():*
        {
            symbol_mc.visible = true;
            setSize(1);
        }

        public function setFill(_arg_1:Number, _arg_2:Number=NaN):*
        {
            Util.setSpriteColor(symbol_mc, _arg_1);
            currColor = _arg_1;
        }

        public function destroy():*
        {
            if (symbol_mc)
            {
                symbol_mc.parent.removeChild(symbol_mc);
                symbol_mc = null;
            };
        }

        public function init(_arg_1:Number, _arg_2:ProjectedPoint, _arg_3:int):*
        {
            _baseSize = _arg_1;
            _id = _arg_3;
            ppoint = _arg_2;
        }

        public function get radius():*
        {
            return (_radius);
        }

        public function get size():Number
        {
            return (currSize);
        }

        public function get id():int
        {
            return (_id);
        }

        public function handleeaser(_arg_1:Object):*
        {
            setSize(_arg_1.value);
            if (_arg_1.done)
            {
            };
        }

        public function get mc():Sprite
        {
            return (symbol_mc);
        }

        public function get hidden():Boolean
        {
            return (!(symbol_mc.visible));
        }

        public function setActiveColor(_arg_1:Number, _arg_2:Number=1):*
        {
            Util.setSpriteColor(symbol_mc, _arg_1, _arg_2);
        }

        public function get color():Number
        {
            return (currColor);
        }

        public function hide(_arg_1:Boolean):*
        {
            if (((_arg_1) && (currSize >= mineaserSize)))
            {
                easer.easeNumber(currSize, 0, hideDuration);
            }
            else
            {
                symbol_mc.visible = false;
            };
        }

        public function getMovieClip():Sprite
        {
            return (symbol_mc);
        }

        public function clearActiveColor():*
        {
            Util.setSpriteColor(symbol_mc, currColor);
        }

        public function get value():Number
        {
            return (currValue);
        }

        public function get baseSize():Number
        {
            return (_baseSize);
        }

        public function get x():Number
        {
            return (ppoint.x);
        }

        public function get y():Number
        {
            return (ppoint.y);
        }

        public function applyScale(_arg_1:Number, _arg_2:Boolean):*
        {
            var _local_3:Number;
            var _local_4:Number;
            _local_3 = (_baseSize * _arg_1);
            if (currSize != _local_3)
            {
                if (!_arg_2)
                {
                    setSize(_local_3);
                }
                else
                {
                    _local_4 = growDuration;
                    if (_local_3 < 10)
                    {
                        _local_4 = (_local_4 * 0.8);
                    }
                    else
                    {
                        if (_local_3 < 15)
                        {
                            _local_4 = (_local_4 * 0.95);
                        };
                    };
                    if (((_arg_2) && ((_local_3 >= mineaserSize) || (currSize >= mineaserSize))))
                    {
                        easer.easeNumber(currSize, _local_3, _local_4);
                    }
                    else
                    {
                        setSize(_local_3);
                    };
                };
            };
        }


    }
}//package mb

