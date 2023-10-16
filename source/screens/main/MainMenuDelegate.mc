import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MainMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :start) {
            WatchUi.pushView(new TimerView(), new TimerDelegate(), WatchUi.SLIDE_UP);
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
