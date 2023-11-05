import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class TimerView extends WatchUi.View {
    var state as TimerViewState = BEGIN;

    var inspectionTimer = new Timer.Timer();
    var inspectionTime = 15;
    var assembleTimer = new Timer.Timer();
    var assembleTime as Float = 0.0f;
    var assembleSyncTimer = new Timer.Timer();
    var assembleStart as Number?;

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

        switchStateToBegin();
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
        assembleTimer.stop();
        assembleSyncTimer.stop();
    }

    function pressedEnter() as Boolean {
        if (state == BEGIN) {
            switchStateToBeginHold();
            return true;
        } else if (state == INSPECTION) {
            switchStateToInspectionHold();
            return true;
        } else if (state == TIMER) {
            switchStateToEnd();
            return true;
        } else {
            return false;
        }
    }

    function releasedEnter() as Boolean {
        if (state == BEGIN_HOLD) {
            switchStateToInspection();
            return true;
        } else if (state == INSPECTION_HOLD) {
            switchStateToTimer();
            return true;
        } else {
            return false;
        }
    }

    function switchStateToBegin() as Void {
        _inspectLabel.setVisible(false);
        _timeLabel.setVisible(true);
        _yourTimeLabel.setVisible(false);

        _timeLabel.setText("scramble");
    }

    function switchStateToBeginHold() as Void {
        state = BEGIN_HOLD;
        _actionLabel.setColor(Graphics.COLOR_GREEN);
        _timeLabel.setColor(Graphics.COLOR_GREEN);
        WatchUi.requestUpdate();
    }

    function switchStateToInspection() as Void {
        state = INSPECTION;
        _actionLabel.setColor(Graphics.COLOR_WHITE);
        _inspectLabel.setVisible(true);
        _timeLabel.setVisible(true);
        _timeLabel.setText(inspectionTime.format("%d"));
        _timeLabel.setColor(Graphics.COLOR_WHITE);
        inspectionTimer = new Timer.Timer();
        inspectionTimer.start(method(:inspectionTimerCallback), 1000, true);

        WatchUi.requestUpdate();
    }

    function switchStateToInspectionHold() as Void {
        state = INSPECTION_HOLD;
        _actionLabel.setColor(Graphics.COLOR_GREEN);
        _timeLabel.setColor(Graphics.COLOR_GREEN);
        WatchUi.requestUpdate();
    }

    function switchStateToTimer() as Void {
        state = TIMER;
        _actionLabel.setColor(Graphics.COLOR_WHITE);
        _actionLabel.setVisible(true);
        _actionLabel.setText("stop");
        _timeLabel.setText("1.34");
        _timeLabel.setColor(Graphics.COLOR_WHITE);
        _inspectLabel.setVisible(false);

        inspectionTimer.stop();
        assembleTimer.start(method(:assembleTimerCallback), 60, true);
        assembleStart = secondsFromBeginOfDay();
        assembleSyncTimer.start(method(:assembleSyncTimerCallback), 1000, true);
        WatchUi.requestUpdate();
    }

    function switchStateToEnd() as Void {
        state = END;
        _actionLabel.setVisible(false);
        _yourTimeLabel.setVisible(true);

        assembleTimer.stop();
        WatchUi.requestUpdate();

        TimesRepository.getInstance().pushTime(assembleTime);
    }

    // Timer functions
    function inspectionTimerCallback() as Void {
        if (inspectionTime > 0) {
            inspectionTime -= 1;
            _timeLabel.setText(inspectionTime.format("%d"));
            WatchUi.requestUpdate();

            if (inspectionTime == 7) {
                vibrate(100, [300]);
            } else if (inspectionTime == 3) {
                vibrate(100, [200, 200, 200]);
            }
        } else {
            inspectionTimer.stop();
        }
    }

    function assembleTimerCallback() as Void {
        assembleTime += 0.09;
        _timeLabel.setText(assembleTime.format("%.02f"));
        WatchUi.requestUpdate();
    }

    function assembleSyncTimerCallback() as Void {
        // Only having the assembleTimerCallback being called was causing a cumulative error
        // delaying the timer. This function syncs every second with the real value.
        var currentTime = secondsFromBeginOfDay();
        assembleTime = (currentTime - assembleStart).toFloat();
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
