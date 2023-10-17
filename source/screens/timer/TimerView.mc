import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class TimerView extends WatchUi.View {
    var state as TimerViewState = BEGIN;

    var inspectionTimer = new Timer.Timer();
    var inspectionTime = 15;

    private var _actionLabel;
    private var _inspectLabel;
    private var _timeLabel;
    private var _yourTimeLabel;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.Timer(dc));

        _actionLabel = findDrawableById("action_label");
        _inspectLabel = findDrawableById("inspect_label");
        _timeLabel = findDrawableById("time_label");
        _yourTimeLabel = findDrawableById("your_time_label");

        startBegin();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        inspectionTimer.stop();
    }

    function pressedEnter() as Boolean {
        if (state == BEGIN) {
            startBeginHold();
            return true;
        } else if (state == INSPECTION) {
            startInspectionHold();
            return true;
        } else if (state == TIMER) {
            startEnd();
            return true;
        } else {
            return false;
        }
    }

    function releasedEnter() as Boolean {
        if (state == BEGIN_HOLD) {
            startInspection();
            return true;
        } else if (state == INSPECTION_HOLD) {
            startTimer();
            return true;
        } else {
            return false;
        }
    }

    function startBegin() as Void {
        _inspectLabel.setVisible(false);
        _timeLabel.setVisible(false);
        _yourTimeLabel.setVisible(false);
    }

    function startBeginHold() as Void {
        state = BEGIN_HOLD;
        _actionLabel.setColor(Graphics.COLOR_GREEN);
        WatchUi.requestUpdate();
    }

    function startInspection() as Void {
        state = INSPECTION;
        _actionLabel.setColor(Graphics.COLOR_WHITE);
        _inspectLabel.setVisible(true);
        _timeLabel.setVisible(true);
        _timeLabel.setText(inspectionTime.format("%d"));
        inspectionTimer = new Timer.Timer();
        inspectionTimer.start(method(:inspectionTimerCallback), 1000, true);

        WatchUi.requestUpdate();
    }

    function startInspectionHold() as Void {
        state = INSPECTION_HOLD;
        _actionLabel.setColor(Graphics.COLOR_GREEN);
        _timeLabel.setColor(Graphics.COLOR_GREEN);
        WatchUi.requestUpdate();
    }

    function startTimer() as Void {
        state = TIMER;
        _actionLabel.setColor(Graphics.COLOR_WHITE);
        _actionLabel.setVisible(true);
        _actionLabel.setText("stop");
        _timeLabel.setText("1.34");
        _timeLabel.setColor(Graphics.COLOR_WHITE);
        _inspectLabel.setVisible(false);
        WatchUi.requestUpdate();
    }

    function startEnd() as Void {
        _actionLabel.setVisible(false);
        _yourTimeLabel.setVisible(true);
        WatchUi.requestUpdate();
    }

    // Timer functions
    function inspectionTimerCallback() as Void {
        if (inspectionTime > 0) {
            inspectionTime -= 1;
            _timeLabel.setText(inspectionTime.format("%d"));
            WatchUi.requestUpdate();
        } else {
            inspectionTimer.stop();
        }
    }
}

enum TimerViewState {
    BEGIN,
    BEGIN_HOLD,
    INSPECTION,
    INSPECTION_HOLD,
    TIMER,
    END,
}
