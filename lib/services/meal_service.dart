import 'package:flutter/material.dart';

class MealServicesPage extends StatefulWidget {
  const MealServicesPage({super.key});

  @override
  State<MealServicesPage> createState() => _MealServicesPageState();
}

class _MealServicesPageState extends State<MealServicesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, Map<String, String>> mealsByDate = {
    "Mon, Jul 14": {
      "Breakfast": "Pancakes, Fruits, Tea",
      "Lunch": "Chicken Curry, Rice, Salad",
      "Dinner": "Vegetable Soup, Bread",
    },
    "Tue, Jul 15": {
      "Breakfast": "Oatmeal, Banana, Coffee",
      "Lunch": "Beef Stew, Potato, Veggies",
      "Dinner": "Grilled Fish, Rice, Vegetables",
    },
    "Wed, Jul 16": {
      "Breakfast": "Eggs, Toast, Juice",
      "Lunch": "Dal, Rice, Mixed Vegetables",
      "Dinner": "Chicken Salad, Soup",
    },
    "Thu, Jul 17": {
      "Breakfast": "Paratha, Yogurt, Tea",
      "Lunch": "Fish Curry, Rice, Salad",
      "Dinner": "Vegetable Stir Fry, Noodles",
    },
    "Fri, Jul 18": {
      "Breakfast": "Cereal, Milk, Fruit",
      "Lunch": "Mutton Curry, Rice, Salad",
      "Dinner": "Paneer Tikka, Roti",
    },
    "Sat, Jul 19": {
      "Breakfast": "Toast, Jam, Coffee",
      "Lunch": "Chicken Biryani, Raita",
      "Dinner": "Lentil Soup, Bread",
    },
    "Sun, Jul 20": {
      "Breakfast": "Smoothie, Muffin, Tea",
      "Lunch": "Vegetable Pulao, Salad",
      "Dinner": "Grilled Chicken, Rice",
    },
  };

  List<String> get _dates => mealsByDate.keys.toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: mealsByDate.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  IconData _mealIcon(String mealType) {
    switch (mealType) {
      case "Breakfast":
        return Icons.free_breakfast;
      case "Lunch":
        return Icons.lunch_dining;
      case "Dinner":
        return Icons.dinner_dining;
      default:
        return Icons.fastfood;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Meal Services'),
        backgroundColor: Colors.grey[850],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _dates.map((date) => Tab(text: date)).toList(),
          indicatorColor: Colors.cyan[400],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _dates.map((date) {
          final meals = mealsByDate[date]!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: meals.entries.map((entry) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: Icon(
                      _mealIcon(entry.key),
                      color: Colors.cyan[700],
                    ),
                    title: Text(
                      entry.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}