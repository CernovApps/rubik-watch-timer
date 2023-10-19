import Toybox.Lang;

using Toybox.Application.Storage;

const TIMES_STORAGE_KEY = "times";

class TimesRepository {
  private static var instance;
  
  static function getInstance() as TimesRepository {
    if (instance == null) {
      instance = new TimesRepository();
    }
    return instance;
  }

  private function initialize() {
  }

  function getTimes() as Array<Float> {
    var result = Storage.getValue(TIMES_STORAGE_KEY);
    if (result == null) {
      return [];
    } else {
      return result;
    }
  }

  function pushTime(time as Float) as Void {
    var times = getTimes();
    times.add(time);
    Storage.setValue(TIMES_STORAGE_KEY, times);
  }

  function reset() as Void {
    Storage.deleteValue(TIMES_STORAGE_KEY);
  }
}
