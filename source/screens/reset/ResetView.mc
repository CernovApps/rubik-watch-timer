import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class ResetView extends WatchUi.View {

    var _label;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.Reset(dc));
        _label = findDrawableById("main_label");
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
    }

    function onHide() as Void {
    }

    function selected() as Boolean {
      TimesRepository.getInstance().reset();
      WatchUi.popView(WatchUi.SLIDE_DOWN);
      WatchUi.showToast("cleared", {});
      WatchUi.requestUpdate();
      return true;
    }
}
