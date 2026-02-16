// =======================================================
// main.dart
// Recipe Finder App 
// =======================================================

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'recipe_detail_page.dart';

void main() {
  runApp(const MyApp());
}

// =======================================================
// ROOT APPLICATION
// =======================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // =======================
      // GLOBAL THEME
      // =======================
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        // 🔥 Fredoka Applied Globally
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
              borderRadius: BorderRadius.circular(14),
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

// =======================================================
// HOME PAGE
// =======================================================
class RecipeHomePage extends StatefulWidget {
  const RecipeHomePage({super.key});

  @override
  State<RecipeHomePage> createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  final TextEditingController _controller = TextEditingController();

  List meals = [];
  bool isLoading = false;

  // ===================================================
  // FETCH RECIPES
  // ===================================================
  Future<void> getRecipes() async {
    String dish = _controller.text.trim();

    if (dish.isEmpty) return;

    setState(() {
      isLoading = true;
      meals = [];
    });

    final url = "https://www.themealdb.com/api/json/v1/1/search.php?s=$dish";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["meals"] != null) {
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

  // ===================================================
  // UI
  // ===================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipe Finder")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= SEARCH FIELD =================
            TextField(
              controller: _controller,
              style: GoogleFonts.fredoka(),
              decoration: InputDecoration(
                hintText: "Search food (pasta, cake...)",
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

            const SizedBox(height: 14),

            // ================= SEARCH BUTTON =================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: getRecipes,
                child: const Text("Search Recipe"),
              ),
            ),

            const SizedBox(height: 20),

            if (isLoading) const CircularProgressIndicator(color: Colors.black),

            const SizedBox(height: 10),

            // ================= LIST =================
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
                    child: Card(
                      elevation: 2,
                      color: Colors.grey[100],
                      margin: const EdgeInsets.only(bottom: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // IMAGE
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              meal["strMealThumb"],
                              height: 190,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // TEXT SECTION
                          Padding(
                            padding: const EdgeInsets.all(14),
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

                                Text("Area: ${meal["strArea"]}"),

                                const SizedBox(height: 4),

                                Text(
                                  "Tags: ${meal["strTags"] ?? "N/A"}",
                                  style: const TextStyle(color: Colors.black54),
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
