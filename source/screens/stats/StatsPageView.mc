import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class StatsPageView extends WatchUi.View {
    var _data as Array<Array<String>> = [];

    var _label1;
    var _label2;
    var _label3;

    function initialize(data as Array<Array<String>>) {
        _data = data;
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.StatsPage(dc));
        _label1 = findDrawableById("label1");
        _label2 = findDrawableById("label2");
        _label3 = findDrawableById("label3");
    }

    function onShow() as Void {
        _label1.setText(textForIndex(0));
        _label2.setText(textForIndex(1));
        _label3.setText(textForIndex(2));
        WatchUi.requestUpdate();
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
    }

    function onHide() as Void {
    }

    function textForIndex(index as Number) as String {
        if (_data.size() > index) {
            return _data[index][0] + ": " + _data[index][1];
        } else {
            return "";
        }
    }
}
