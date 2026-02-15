// ========================================
// recipe_detail_page.dart
// Recipe Full Detail Screen
// ========================================

import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final Map meal;

  const RecipeDetailPage({super.key, required this.meal});

  // ====================================
  // FUNCTION TO EXTRACT INGREDIENTS
  // ====================================
  List<String> getIngredients() {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      String ingredient = meal["strIngredient$i"] ?? "";
      String measure = meal["strMeasure$i"] ?? "";

      if (ingredient.isNotEmpty) {
        ingredients.add("$ingredient - $measure");
      }
    }

    return ingredients;
  }

  @override
  Widget build(BuildContext context) {
    List<String> ingredients = getIngredients();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Recipe Details",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large Image
            Image.network(
              meal["strMealThumb"],
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal["strMeal"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text("Category: ${meal["strCategory"]}"),

                  Text("Area: ${meal["strArea"]}"),

                  const SizedBox(height: 6),

                  Text(
                    "Tags: ${meal["strTags"] ?? "N/A"}",
                    style: const TextStyle(color: Colors.black54),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Ingredients",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ingredients
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text("• $item"),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Instructions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    meal["strInstructions"] ?? "",
                    style: const TextStyle(height: 1.5),
                  ),

                  const SizedBox(height: 20),

                  if (meal["strYoutube"] != null && meal["strYoutube"] != "")
                    Text(
                      "Youtube: ${meal["strYoutube"]}",
                      style: const TextStyle(color: Colors.blue),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
