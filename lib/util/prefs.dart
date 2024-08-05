import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_app/util/util.dart';



class Prefs {
  final SharedPreferences sharedPreferences;
  static const mm = '💜💜💜💜💜Prefs 💜💜';

  Prefs(this.sharedPreferences);

  void saveMode(int mode) {
    sharedPreferences.setInt('mode', mode);
  }

  int getMode() {
    var mode = sharedPreferences.getInt('mode');
    if (mode == null) {
      pp('$mm ... mode not found, returning -1');
      return -1;
    }
    return mode;
  }

  void saveColorIndex(int index) async {
    sharedPreferences.setInt('color', index);
    pp('$mm ... color index cached: $index');
    return null;
  }

  int getColorIndex() {
    var color = sharedPreferences.getInt('color');
    if (color == null) {
      pp('$mm ... return default color index 0');
      return 0;
    }
    return color;
  }

  void saveLimit(int limit) async {
    sharedPreferences.setInt('limit', limit);
    pp('$mm ... limit cached: $limit');
    return null;
  }

  int getLimit() {
    var count = sharedPreferences.getInt('limit');
    if (count == null) {
      return 10;
    }
    pp('$mm ... limit: $count');
    return count;
  }

}
