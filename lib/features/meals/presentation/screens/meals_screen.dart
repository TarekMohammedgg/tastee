import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/features/home/presentation/screens/widgets/custom_container.dart';
import 'package:tastee/features/meals/presentation/cubit/meals_cubit.dart';
import 'package:tastee/features/meals/presentation/cubit/meals_states.dart';

class MealsScreen extends StatelessWidget {
  final String categoryName;

  const MealsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: BlocProvider(
        create: (context) => MealsCubit()..getMeals(categoryName),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: BlocBuilder<MealsCubit, MealsStates>(
            builder: (context, state) {
              if (state is MealsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MealsError) {
                return Center(child: Text(state.errorMessage));
              } else if (state is MealsSuccess) {
                return GridView.builder(
                  itemCount: state.meals.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 155 / 176,
                  ),
                  itemBuilder: (context, index) {
                    final meal = state.meals[index];
                    return CustomContainer(
                      image: meal.strMealThumb ?? '',
                      title: meal.strMeal ?? '',
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
