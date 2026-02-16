import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:reciepe_finder/recipe_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.fredokaTextTheme(),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: GoogleFonts.fredoka(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(14),
            ),

            textStyle: GoogleFonts.fredoka(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),

      home: const RecipeHomePage(),
    );
  }
}

// Home Page Code

class RecipeHomePage extends StatefulWidget {
  const RecipeHomePage({super.key});

  @override
  State<RecipeHomePage> createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  final TextEditingController _controller = TextEditingController();

  List meals = [];
  bool isLoading = false;

  // Fetch Recipes From Server
  // -------------------------

  Future<void> getRecipes() async {
    String dish = _controller.text.trim();

    // Agar Input Me Kuch Nahi Hua Na To Return Kardega
    if (dish.isEmpty) return;

    // State Ko Set Karenge Taki Loading Dikhaye
    setState(() {
      isLoading = true;
      meals = [];
    });

    // Making Final Usrl To get Data
    final baseUrl =
        "https://www.themealdb.com/api/json/v1/1/search.php?s=$dish";

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Agar na meal jo search kara hai vo mila usse related to
        if (data['meals'] != null) {
          setState(() {
            meals = data["meals"].take(15).toList();
          });
        }
      }
    } catch (e) {
      print("Error: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipe Finder")),

      body: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            // ================ Search Fields ===============
            TextField(
              controller: _controller,
              style: GoogleFonts.fredoka(),
              decoration: InputDecoration(
                hintText: "Search Food (pasta, cake...)",
                hintStyle: GoogleFonts.fredoka(),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 14),

            // Search Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: getRecipes,
                child: Text("Search Recipe"),
              ),
            ),

            SizedBox(height: 20),

            // Showing Loading Screen Before Getting Data
            if (isLoading) const CircularProgressIndicator(color: Colors.black),

            SizedBox(height: 10),

            // ===================== Printing Or Showing List Of Dishes
            Expanded(
              child: ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage(meal: meal),
                        ),
                      );
                    },

                    // Card For Dish
                    child: Card(
                      elevation: 2,
                      color: Colors.grey[100],
                      margin: const EdgeInsets.only(bottom: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16),
                      ),

                      // Content Inside Card
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Image Of Dish
                          ClipRRect(
                            borderRadius: const BorderRadiusGeometry.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              meal["strMealThumb"],
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // Text Area
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meal["strMeal"],
                                  style: GoogleFonts.fredoka(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),

                                Text("Category: ${meal["strCategory"]}"),
                                Text("Area: ${meal["strCategory"]}"),

                                const SizedBox(height: 4),
                                Text(
                                  "Tags: ${meal["strTags"] ?? "N/A"}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
