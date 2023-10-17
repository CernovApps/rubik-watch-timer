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
            // TODO fix
            System.println("times");
        } else if (item == :stats) {
            // TODO fix
            System.println("stats");
        } else if (item == :reset) {
            // TODO fix
            System.println("reset");
        }
    }
}
