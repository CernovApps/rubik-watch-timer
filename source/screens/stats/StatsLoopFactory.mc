import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class StatsLoopFactory extends WatchUi.ViewLoopFactory {
    function initialize() {
        ViewLoopFactory.initialize();
    }

    function getSize() as Number {
        return 3;
    }

    function getView(page as Number) as Array<WatchUi.View or WatchUi.BehaviorDelegate> or Null {
        var view = new StatsPageView([["best", "12.34"],["worst", "23.45"],["avg", "20.00"]]);

        return [view, new WatchUi.BehaviorDelegate()];
    }
}
