// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.zooming.ScaleSet

package mb.zooming
{
    public class ScaleSet 
    {

        protected var relScaleArr:Array;
        protected var _numLevels:int = 0;


        public function get numLevels():int
        {
            return (_numLevels);
        }

        public function convScaleToLevel(_arg_1:Number):int
        {
            var _local_2:Number;
            var _local_3:int;
            _local_3 = 1;
            while (_local_3 < _numLevels)
            {
                _local_2 = relScaleArr[_local_3];
                if (_arg_1 < (_local_2 - 1E-5))
                {
                    return (_local_3);
                };
                _local_3++;
            };
            return (_numLevels);
        }

        public function convLevelToScale(_arg_1:int):Number
        {
            if (_arg_1 < 1)
            {
                _arg_1 = 1;
            };
            if (_arg_1 > _numLevels)
            {
                _arg_1 = _numLevels;
            };
            return (relScaleArr[(_arg_1 - 1)]);
        }


    }
}//package mb.zooming

