// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//CPI

package 
{
    import mb.MapMain;
    import mb.ShapeLayer;
    import mb.symbols.IShapeSource;
    import mb.MapStack;
    import mb.DataSource;
    import mb.PopupDisplay;
    import mb.PointLayer;
    import mb.projections.Projection;
    import mb.Waiter;
    import mb.zooming.ZoomTool;
    import mb.PointDataSource;
    import mb.symbols.LegacyShapeSource;
    import mb.Notifier;
    import flash.display.MovieClip;
    import mb.Record;
    import mb.Util;
    import mb.LabelStyle;
    import mb.LabelField;
    import mb.ImageLayer;
    import mb.expressions.Expression;
    import mb.placement.ShapeLayerAlignment;
    import mb.NavigationManager;
    import flash.display.*;
    import mb.*;
    import mb.expressions.*;
    import mb.symbols.*;
    import mb.easing.*;
    import flash.events.*;
    import mb.projections.*;
    import mb.placement.*;
    import mb.zooming.*;
    import mb.importing.*;

    public class CPI extends MapMain 
    {

        private const dataHome:String = (webHome + "data/");
        private const webHome:String = "http://graphics8.nytimes.com/packages/flash/business/20080504_CPI/";

        private var _leaf_lyr:ShapeLayer;
        private var _leaf_lyr2:ShapeLayer;
        private var _leaf_vec:IShapeSource;
        private var _map:MapStack;
        private var _l1_data:DataSource;
        private var _popup:PopupDisplay;
        private var _map2:MapStack;
        private var _l0_vec:IShapeSource;
        private var _l1_vec:IShapeSource;
        private var _label_lyr:PointLayer;
        private var _proj:Projection;
        private var _cpi_data:DataSource;
        private var _preload:Waiter;
        private var _zoomer:ZoomTool;
        private var _leaf_data:PointDataSource;

        public function CPI(_arg_1:MovieClip)
        {
            super(_arg_1);
            _proj = new Projection();
            _leaf_vec = new LegacyShapeSource((dataHome + "leaves.swf"), _proj, _proj);
            _l1_vec = new LegacyShapeSource((dataHome + "l1.swf"), _proj, _proj);
            _l0_vec = new LegacyShapeSource((dataHome + "l0.swf"), _proj, _proj);
            _leaf_data = new PointDataSource("LAT", "LONG");
            _leaf_data.setField("ID", DataSource.STRING);
            _leaf_data.setField("NAME", DataSource.STRING);
            _leaf_data.loadTabData((dataHome + "leaves.txt"));
            _l1_data = new DataSource();
            _l1_data.setField("ID", DataSource.STRING);
            _l1_data.setField("NAME", DataSource.STRING);
            _l1_data.loadTabData((dataHome + "l1.txt"));
            _cpi_data = new DataSource();
            _cpi_data.setField("V1", DataSource.STRING);
            _cpi_data.setField("shortName", DataSource.STRING);
            _cpi_data.setField("changeColor", DataSource.DOUBLE);
            _cpi_data.setField("weight", DataSource.DOUBLE);
            _cpi_data.setField("notes", DataSource.STRING);
            _cpi_data.loadTabData((dataHome + "cpiData2.txt"));
            _preload = new Waiter();
            _preload.waitFor(_leaf_vec);
            _preload.waitFor(_leaf_data);
            _preload.waitFor(_cpi_data);
            _preload.waitFor(_l1_vec);
            _preload.waitFor(_l0_vec);
            _preload.waitFor(_l1_data);
            _preload.startWaiting();
            _preload.setCallback(this, handlePreload, Notifier.READY);
        }

        private function handleOver(_arg_1:Object):*
        {
            var _local_2:Record;
            var _local_3:String;
            var _local_4:Number;
            var _local_5:String;
            var _local_6:Number;
            var _local_7:String;
            var _local_8:String;
            _local_2 = _arg_1.data.rec;
            if (!_local_2)
            {
                return;
            };
            _map.mouse.useHandCursor = true;
            _map.zooming = true;
            _local_3 = _local_2.getString("shortName");
            _local_4 = _local_2.getNumber("changeColor");
            _local_5 = ((((_local_4 > 0) ? "+" : "") + Util.formatValue(_local_4, 1)) + "%");
            if (isNaN(_local_4))
            {
                _local_5 = "no data";
            };
            _local_6 = _local_2.getNumber("weight");
            _local_7 = (Util.formatValue(_local_6, 1) + "%");
            _local_8 = _local_2.getString("notes");
            _popup.display(_local_3, [["Share of spending", _local_7], ["Change, 2007-08", _local_5]], "", _local_8);
        }

        private function handleOut(_arg_1:Object):*
        {
            _map.mouse.useHandCursor = false;
            _map.zooming = false;
            _popup.hide();
        }

        private function getColorExpression(_arg_1:String):String
        {
            var _local_2:Array;
            var _local_3:Array;
            var _local_4:String;
            var _local_5:int;
            _local_2 = [5401214, 8167096, 11452627, 15264498, 15790051, 16770237, 16307354, 15514457, 13407615, 12417121];
            _local_3 = [-10, -2, 0, 2, 4, 6, 10, 20, 40];
            _local_4 = (_arg_1 + " NULL == 0xcccccc ?: ");
            _local_5 = 0;
            while (_local_5 < _local_3.length)
            {
                _local_4 = (_local_4 + (((((_arg_1 + " ") + _local_3[_local_5]) + " < ") + _local_2[_local_5]) + " ?: "));
                _local_5++;
            };
            _local_4 = (_local_4 + (_local_2[_local_5] + " : "));
            return (_local_4);
        }

        private function handleRescale(_arg_1:Object):*
        {
            var _local_2:Number;
            var _local_3:MovieClip;
            var _local_4:MovieClip;
            _local_2 = _map.navigation.scale;
            _local_3 = _root["callouts_mc"];
            _local_4 = _root["labels0_mc"];
            if (_local_2 <= 1.005)
            {
                if (!_local_3.visible)
                {
                    _local_3.visible = true;
                    _local_4.visible = true;
                };
            }
            else
            {
                if (_local_3.visible)
                {
                    _local_3.visible = false;
                    _local_4.visible = false;
                };
            };
        }

        private function handlePreload(_arg_1:Object):*
        {
            var _local_2:*;
            var _local_3:*;
            var _local_4:LabelStyle;
            var _local_5:LabelField;
            var _local_6:ImageLayer;
            _leaf_data.joinMatchingFields("V1:ID", _cpi_data, ["shortName:shortName", "changeColor:changeColor", "weight:weight", "notes:notes", "V1:V1"]);
            _leaf_lyr = new ShapeLayer(_leaf_vec, _leaf_data);
            _leaf_lyr.style.setFill(0xCCCCCC);
            _leaf_lyr.style.setStroke(1, 0x777777);
            _leaf_lyr.setCallback(this, handleOver, ShapeLayer.ROLL_OVER);
            _leaf_lyr.setCallback(this, handleOut, ShapeLayer.ROLL_OUT);
            _leaf_lyr.hover.setStroke(2, 0);
            _leaf_lyr.style.fillExpression = new Expression(getColorExpression("changeColor"), _leaf_data);
            _leaf_lyr2 = new ShapeLayer(_leaf_vec, _leaf_data);
            _leaf_lyr2.style.setFill(0xCCCCCC);
            _leaf_lyr2.style.setStroke(1, 0x777777);
            _leaf_lyr2.setCallback(this, handleOver, ShapeLayer.ROLL_OVER);
            _leaf_lyr2.setCallback(this, handleOut, ShapeLayer.ROLL_OUT);
            _leaf_lyr2.hover.setStroke(2, 0);
            _leaf_lyr2.style.fillExpression = new Expression(getColorExpression("changeColor"), _leaf_data);
            _l1_data.joinMatchingFields("V1:ID", _cpi_data, ["shortName:shortName", "changeColor:changeColor", "weight:weight"]);
            _local_2 = new ShapeLayer(_l1_vec, _l1_data);
            _local_2.style.setStroke(2, 0);
            _local_3 = new ShapeLayer(_l0_vec);
            _local_3.style.setFill(0x999999);
            _local_3.style.setStroke(5, 0x999999);
            _local_4 = new LabelStyle(_leaf_data);
            _local_4.textField = "shortName";
            _local_5 = new LabelField();
            _local_5.size = 12;
            _local_5.width = 150;
            _local_5.multiline = true;
            _local_4.template = _local_5;
            _local_6 = new ImageLayer(_root["details_mc"]);
            _local_6.minScale = 2.9999;
            _local_6.maxScale = 3.0001;
            _map = new MapStack(_align, _proj, new ShapeLayerAlignment(_align, _proj, _leaf_vec, [20, 28, 30, 25]));
            _map.navigation.scales = [1, 3];
            _map.addLayer(_local_3);
            _map.addLayer(_leaf_lyr);
            _map.addLayer(_local_6);
            _map.panning = true;
            _map.zooming = true;
            _map.load();
            _map.navigation.setCallback(this, handleRescale, NavigationManager.RESCALE);
            _zoomer = new ZoomTool(_root["zoom_mc"].in_mc, _root["zoom_mc"].out_mc, _map);
            _popup = new PopupDisplay(_root, _map.mouse);
            _root["labels0_mc"].mouseEnabled = false;
        }


    }
}//package 

