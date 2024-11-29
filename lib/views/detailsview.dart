import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/datas.dart'; // Import your PlanetInfo model

class DetailsView extends StatefulWidget {
  final PlanetInfo? planetInfo;

  const DetailsView({super.key, this.planetInfo});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late bool isFavorite = false ;

  @override
  void initState() {
    super.initState();
    // Load favorite planets when the page is initialized
    _loadFavorites();
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
        isFavorite = favoritePlanets.contains(widget.planetInfo);
      });
    } else {
      setState(() {
        isFavorite = false;
      });
    }
  }

  // Save favorite planets to SharedPreferences
  void _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> favoritesMap = favoritePlanets.map((planet) => planet.toMap()).toList();
    String favoritesJson = json.encode(favoritesMap);
    await prefs.setString('favoritePlanets', favoritesJson);
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        favoritePlanets.remove(widget.planetInfo);
      } else {
        favoritePlanets.add(widget.planetInfo!);
      }
      isFavorite = !isFavorite;
    });
    _saveFavorites(); // Save the updated favorites list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 32),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 300),
                    Text(
                      widget.planetInfo!.name.toString(),
                      style: const TextStyle(
                          fontSize: 55,
                          fontFamily: 'Avenir',
                          color: Colors.black,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.left,
                    ),
                    const Text(
                      "Solar System",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Avenir',
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: toggleFavorite,
                    ),
                    const Divider(color: Colors.black38),
                    const SizedBox(height: 30),
                    Text(
                      widget.planetInfo!.description.toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'Avenir',
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                      maxLines: 60,
                    ),
                    const SizedBox(height: 30),
                    const Divider(color: Colors.black38),
                    const SizedBox(height: 15),
                    const Text(
                      "Gallery",
                      style: TextStyle(
                          fontSize: 24,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'Avenir',
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                      maxLines: 40,
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.planetInfo!.images!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  widget.planetInfo!.images![index],
                                  fit: BoxFit.cover,
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: -70,
              child: Hero(
                  tag: widget.planetInfo!.position.toString(),
                  child: Image.asset(widget.planetInfo!.iconImage.toString())),
            ),
            Positioned(
              top: 60,
              left: 32,
              child: Text(
                widget.planetInfo!.position.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 247,
                    color: Colors.grey.withOpacity(0.2)),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          ],
        ),
      ),
    );
  }
}
