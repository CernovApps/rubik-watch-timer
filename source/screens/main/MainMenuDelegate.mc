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
            var times = TimesRepository.getInstance().getTimes();
            System.println(times.toString());
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
