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

  function deleteTime(index as Number) as Array<Float> {
    var times = getTimes();
    var result = times.slice(0, index).addAll(times.slice(index+1, null));
    Storage.setValue(TIMES_STORAGE_KEY, result);    
    return result;
  }

  function reset() as Void {
    Storage.deleteValue(TIMES_STORAGE_KEY);
  }
}
