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

    var deleted = false;

    function selected() as Boolean {
      if (!deleted) {
        TimesRepository.getInstance().reset();
        _label.setText("data reset");
        WatchUi.requestUpdate();
        deleted = true;
        return true;
      }
      return false;
    }
}
