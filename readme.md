# 🍽️ Recipe Finder App

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![API](https://img.shields.io/badge/API-TheMealDB-orange)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Active-success)

A clean, modern **Recipe Finder Application** built with **Flutter**, integrated with **TheMealDB REST API**, and styled using **Google Fonts (Fredoka)** in a monochrome UI system.

---

# 📱 Features

- 🔎 Search recipes by name
- 📋 Display up to 15 results per search
- 🖼 View recipe image
- 📄 Navigate to detailed recipe page
- 🥘 Ingredient extraction (dynamic 1–20 fields)
- 🎥 YouTube link display
- 🎨 Monochrome professional UI
- 🔤 Google Fonts (Fredoka) typography

---

# 📸 Screenshots

| Home Screen | Detail Screen |
|------------|---------------|
| ![Home](screenshots/home.jpg) | ![Detail](screenshots/detail.jpg) |

---

# 🏗️ Architecture Overview

This project follows a simple layered structure suitable for beginner-to-intermediate applications.

```
UI Layer (Widgets)
   ↓
State Management (setState)
   ↓
API Service (http)
   ↓
TheMealDB REST API
```

---

# 📂 Project Structure

```
lib/
 ├── main.dart
 └── recipe_detail_page.dart
```

### main.dart
- App theme configuration
- API request logic
- Search UI
- List rendering
- Navigation handling

### recipe_detail_page.dart
- Detailed UI
- Ingredient extraction logic
- Instruction rendering

---

# 🌐 API Integration

### API Used

```
https://www.themealdb.com/api/json/v1/1/search.php?s={dishName}
```

### Example Request

```
https://www.themealdb.com/api/json/v1/1/search.php?s=pasta
```

---

# 🔄 API Flow (Detailed)

```
User enters dish name
        ↓
Press Search Button
        ↓
getRecipes() triggered
        ↓
HTTP GET request sent
        ↓
JSON response received
        ↓
Decode using jsonDecode()
        ↓
Extract data["meals"]
        ↓
Limit to 15 results
        ↓
Update UI using setState()
        ↓
ListView rebuilds
```

---

# 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.6
  google_fonts: ^6.1.0
```

---

# 🎨 Theming System

Global theme configured inside `MaterialApp`:

```dart
theme: ThemeData(
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.fredokaTextTheme(),
)
```

### Design System:

- Primary: Black
- Background: White
- Surface: Grey[100]
- Font: Fredoka
- Rounded Corners: 14–16px
- Soft elevation cards

---

# 🧠 Core Concepts Used

| Concept | Why Used |
|----------|----------|
| StatefulWidget | API data changes UI |
| setState() | Rebuild UI after data update |
| ListView.builder | Efficient dynamic rendering |
| Navigator.push | Page navigation |
| InkWell | Click effect |
| GoogleFonts | Modern typography |
| http package | REST API communication |

---

# 🥘 Ingredient Extraction Logic

TheMealDB returns up to 20 ingredients:

```
strIngredient1
strIngredient2
...
strIngredient20
```

We dynamically extract them using:

```dart
for (int i = 1; i <= 20; i++)
```

This ensures:
- Clean ingredient list
- No null values
- Automatic scaling

---

# ⚙️ Installation Guide

### 1️⃣ Clone Repository

```bash
git clone https://github.com/apandey-dev/recipe-finder-app.git
```

### 2️⃣ Navigate into project

```bash
cd recipe-finder-app
```

### 3️⃣ Install dependencies

```bash
flutter pub get
```

### 4️⃣ Run application

```bash
flutter run
```

---

# 🧪 Testing the API

You can test API manually via browser:

```
https://www.themealdb.com/api/json/v1/1/search.php?s=cake
```

---

# 🚀 Performance Considerations

- Limited results to 15
- Lazy list rendering
- Stateless detail screen
- Minimal rebuild scope
- No unnecessary global state

---

# 🔐 Error Handling

```dart
try {
  // API call
} catch (e) {
  print("Error: $e");
}
```

Prevents crashes on:
- No internet
- Invalid response
- API downtime

---

# 🔮 Future Improvements (Scalable Version)

- Model class instead of Map
- Provider / Riverpod state management
- Search debounce
- Caching API results
- Open YouTube inside app
- Dark mode support
- Shimmer loading effect
- Favorites feature
- Offline storage (Hive / SQLite)

---

# 📊 Architecture Diagram

```
+--------------------+
|   User Interface   |
|  (Widgets Layer)   |
+--------------------+
           ↓
+--------------------+
|   State Handling   |
|     setState()     |
+--------------------+
           ↓
+--------------------+
|   API Service      |
|   http.get()       |
+--------------------+
           ↓
+--------------------+
|   TheMealDB API    |
+--------------------+
```

---

# 🤝 Contribution Guide

1. Fork repository
2. Create new branch
3. Make changes
4. Submit Pull Request

---

# 📜 License

This project is licensed under the MIT License.

---

# 👨‍💻 Author: Arpit Pandey

Built using:

- Flutter
- Dart
- TheMealDB API
- Google Fonts (Fredoka)

---

# ⭐ Support

If you like this project:

- Star the repository
- Share with others
- Contribute improvements

---

# 🏁 Final Notes

This project demonstrates:

- REST API integration in Flutter
- JSON parsing
- UI architecture fundamentals
- Clean design implementation
- Professional documentation practices

It is suitable for:

- Portfolio projects
- Learning API integration
- Beginner to intermediate Flutter developers
