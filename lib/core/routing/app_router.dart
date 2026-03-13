import 'package:flutter/material.dart';
import 'package:tastee/core/constants/app_strings.dart';
import 'package:tastee/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tastee/features/home/presentation/screens/home_screen.dart';
import 'package:tastee/features/meal_recipe/presentation/screens/meal_recipe_screen.dart';
import 'package:tastee/features/meals/presentation/screens/meals_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/features/auth/data/repo/auth_repo.dart';
import 'package:tastee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tastee/features/auth/presentation/screens/login_screen.dart';
import 'package:tastee/features/auth/presentation/screens/signup_screen.dart';
import 'package:tastee/layout_nav_bottom_bar/presentation/screens/layout_bottom_nav_bar_screen.dart';
import 'routes.dart';

class AppRouter {
  final FavouriteCubit favouriteCubit;

  AppRouter({required this.favouriteCubit});

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(AuthRepo()),
            child: const LoginScreen(),
          ),
        );

      case Routes.signup:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(AuthRepo()),
            child: const SignupScreen(),
          ),
        );

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.layoutBottomNavBar:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: favouriteCubit,
            child: const LayoutBottomNavBarScreen(),
          ),
        );

      case Routes.meals:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: favouriteCubit,
            child: MealsScreen(categoryName: categoryName),
          ),
        );

      case Routes.mealRecipe:
        final mealId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: favouriteCubit,
            child: MealRecipeScreen(mealId: mealId),
          ),
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
