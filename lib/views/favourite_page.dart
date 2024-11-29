import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/datas.dart'; // Import your PlanetInfo model

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<PlanetInfo> favoritePlanets = []; // Add initialization for the list

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // Load favorites when the page is initialized
  }

  // Load favorite planets from SharedPreferences
  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favoritesData = prefs.getString('favoritePlanets');
    if (favoritesData != null) {
      List<dynamic> jsonList = json.decode(favoritesData);
      setState(() {
        favoritePlanets = jsonList
            .map((planet) => PlanetInfo.fromMap(Map<String, dynamic>.from(planet)))
            .toList();
      });
    }
  }

  void _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> favoritesMap = favoritePlanets.map((planet) => planet.toMap()).toList();
    String favoritesJson = json.encode(favoritesMap);
    await prefs.setString('favoritePlanets', favoritesJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favorite Planets'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: favoritePlanets.isEmpty
              ? const Center(
            child: Text(
              'No favorite planets yet!',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
          )
              : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Colors.black38),
                const SizedBox(height: 15),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoritePlanets.length,
                  itemBuilder: (context, index) {
                    final planet = favoritePlanets[index];
                    Object heroTag = planet.name ?? planet.id ?? "planet_$index"; // Use unique identifier for tag

                    return Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Hero(
                              tag: heroTag, // Use unique hero tag
                              child: Image.asset(
                                planet.iconImage.toString(),
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    planet.name.toString(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    planet.description!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                favoritePlanets.removeAt(index);
                              });
                              _saveFavorites(); // Save after removing
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${planet.name} removed'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
