// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.PointDataSource

package mb
{
    import flash.geom.Point;

    public class PointDataSource extends DataSource 
    {

        private static var _p:Point = new Point();

        private const _spatialKeyField:String = "_LLKEY";

        private var _latField:String = null;
        private var _longField:String = null;
        private var _haveSpatialKey:Boolean = false;

        public function PointDataSource(_arg_1:String, _arg_2:String)
        {
            setField(_arg_1, DOUBLE);
            setField(_arg_2, DOUBLE);
            _latField = _arg_1;
            _longField = _arg_2;
        }

        public function getLatLong(_arg_1:int):Point
        {
            _p.x = dataObj[_longField][_arg_1];
            _p.y = dataObj[_latField][_arg_1];
            return (_p);
        }

        public function getSpatialKey(_arg_1:int):String
        {
            if (!_haveSpatialKey)
            {
                if (!this.ready)
                {
                    return (null);
                };
                createSpatialKeyField(_spatialKeyField);
                _haveSpatialKey = true;
            };
            return (dataObj[_spatialKeyField][_arg_1]);
        }

        private function createSpatialKeyField(_arg_1:String):*
        {
            var _local_2:Array;
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:String;
            addField(_arg_1, STRING);
            _local_2 = dataObj[_arg_1];
            _local_3 = dataObj[_latField];
            _local_4 = dataObj[_longField];
            _local_5 = 0;
            while (_local_5 < numRecords)
            {
                _local_6 = ((String(_local_3[_local_5]) + ":") + String(_local_4[_local_5]));
                _local_2[_local_5] = _local_6;
                _local_5++;
            };
        }


    }
}//package mb

