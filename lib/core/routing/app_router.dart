import 'package:flutter/material.dart';
import 'package:tastee/core/constants/app_strings.dart';
import 'package:tastee/features/home/presentation/screens/home_screen.dart';
import 'package:tastee/features/meal_recipe/presentation/screens/meal_recipe_screen.dart';
import 'package:tastee/features/meals/presentation/screens/meals_screen.dart';
import 'package:tastee/layout_nav_bottom_bar/presentation/screens/layout_bottom_nav_bar_screen.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.layoutBottomNavBar:
        return MaterialPageRoute(
          builder: (_) => const LayoutBottomNavBarScreen(),
        );

      case Routes.meals:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MealsScreen(categoryName: categoryName),
        );

      case Routes.mealRecipe:
        final mealId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MealRecipeScreen(mealId: mealId),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text(AppStrings.noRouteFound)),
          ),
        );
    }
  }
}
