import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/datas.dart';

class SharedPrefsHelper {
  static const String _favoritesKey = 'favoritePlanets';

  // Save the list of favorite planets
  static Future<void> saveFavorites(List<PlanetInfo> favoritePlanets) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedPlanets = favoritePlanets.map((planet) => planet.toJson()).toList();
    prefs.setStringList(_favoritesKey, encodedPlanets);
  }

  // Load the list of favorite planets
  static Future<List<PlanetInfo>> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedPlanets = prefs.getStringList(_favoritesKey);
    if (encodedPlanets != null) {
      return encodedPlanets.map((planet) => PlanetInfo.fromJson(planet)).toList();
    } else {
      return [];
    }
  }

  // Remove all favorite planets from shared preferences
  static Future<void> clearFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_favoritesKey);
  }
}
