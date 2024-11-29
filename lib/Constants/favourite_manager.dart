import 'package:planets/model/datas.dart';

class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<PlanetInfo> _favorites = [];
  List<PlanetInfo> favoritePlanets = [];


  List<PlanetInfo> get favorites => _favorites;

  void toggleFavorite(PlanetInfo planet) {
    if (_favorites.contains(planet)) {
      _favorites.remove(planet);
    } else {
      _favorites.add(planet);
    }
  }

  void removeFavorite(PlanetInfo planet) {
    _favorites.remove(planet);
  }
}
