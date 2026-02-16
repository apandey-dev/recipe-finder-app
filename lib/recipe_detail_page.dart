import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailPage extends StatelessWidget {
  final Map meal;

  const RecipeDetailPage({super.key, required this.meal});

  // ====================================
  // EXTRACT INGREDIENTS SAFELY
  // ====================================
  List<String> getIngredients() {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = (meal["strIngredient$i"] ?? "").toString().trim();
      final measure = (meal["strMeasure$i"] ?? "").toString().trim();

      if (ingredient.isNotEmpty) {
        if (measure.isNotEmpty) {
          ingredients.add("$ingredient - $measure");
        } else {
          ingredients.add(ingredient);
        }
      }
    }

    return ingredients;
  }

  // ====================================
  // OPEN YOUTUBE LINK
  // ====================================
  Future<void> openYoutube(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> ingredients = getIngredients();

    final String imageUrl = meal["strMealThumb"] ?? "";
    final String title = meal["strMeal"] ?? "Unknown Recipe";
    final String category = meal["strCategory"] ?? "N/A";
    final String area = meal["strArea"] ?? "N/A";
    final String tags = meal["strTags"] ?? "N/A";
    final String instructions = meal["strInstructions"] ?? "";
    final String youtube = meal["strYoutube"] ?? "";

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
            // ================= IMAGE =================
            Image.network(
              imageUrl,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 260,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image_not_supported, size: 40),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= TITLE =================
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text("Category: $category"),
                  Text("Area: $area"),

                  const SizedBox(height: 6),

                  Text(
                    "Tags: $tags",
                    style: const TextStyle(color: Colors.black54),
                  ),

                  const SizedBox(height: 20),

                  // ================= INGREDIENTS =================
                  const Text(
                    "Ingredients",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  ...ingredients.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text("• $item"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= INSTRUCTIONS =================
                  const Text(
                    "Instructions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(instructions, style: const TextStyle(height: 1.5)),

                  const SizedBox(height: 20),

                  // ================= YOUTUBE =================
                  if (youtube.isNotEmpty)
                    GestureDetector(
                      onTap: () => openYoutube(youtube),
                      child: const Text(
                        "Watch on YouTube",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
