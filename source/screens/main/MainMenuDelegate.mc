import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MainMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :start) {
            var timerView = new TimerView();
            WatchUi.pushView(timerView, new TimerDelegate(timerView), WatchUi.SLIDE_UP);
        } else if (item == :times) {
            var timesView = new TimesView();
            WatchUi.pushView(timesView, new TimesDelegate(timesView), WatchUi.SLIDE_UP);
        } else if (item == :stats) {
            var loop = new WatchUi.ViewLoop(new StatsLoopFactory(), {:wrap => true});
            WatchUi.pushView(loop, new ViewLoopDelegate(loop), WatchUi.SLIDE_IMMEDIATE);
        } else if (item == :reset) {
            var resetView = new ResetView();
            WatchUi.pushView(resetView, new ResetDelegate(resetView), WatchUi.SLIDE_UP);
        }
    }
}
