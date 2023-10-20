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
            // TODO fix
            System.println("stats");
        } else if (item == :reset) {
            // TODO fix
            TimesRepository.getInstance().reset();
            System.println("reset");
        }
    }
}
