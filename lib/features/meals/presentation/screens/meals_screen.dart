import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tastee/core/constants/app_colors.dart';
import 'package:tastee/core/constants/app_style.dart';
import 'package:tastee/core/routing/routes.dart';
import 'package:tastee/features/home/presentation/screens/widgets/custom_container.dart';
import 'package:tastee/features/meals/data/models/meal_model.dart';
import 'package:tastee/features/meals/presentation/cubit/meals_cubit.dart';
import 'package:tastee/features/meals/presentation/cubit/meals_states.dart';

class MealsScreen extends StatelessWidget {
  final String categoryName;

  const MealsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$categoryName Recipes", style: AppTextStyles.bold18),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: AppColors.primary),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: BlocProvider(
        create: (context) => MealsCubit()..getMeals(categoryName),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: BlocBuilder<MealsCubit, MealsStates>(
            builder: (context, state) {
              final isLoading = state is MealsLoading;

              if (state is MealsError) {
                return Center(child: Text(state.errorMessage));
              }

              final meals = state is MealsSuccess
                  ? state.meals
                  : List.generate(
                      6,
                      (index) => MealModel(
                        strMeal: 'Loading',
                        strMealThumb: '',
                        idMeal: '',
                      ),
                    );

              return Skeletonizer(
                enabled: isLoading,
                child: GridView.builder(
                  itemCount: meals.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 155 / 176,
                  ),
                  itemBuilder: (context, index) {
                    final meal = meals[index];

                    return GestureDetector(
                      onTap: () {
                        if (!isLoading && meal.idMeal != null) {
                          Navigator.pushNamed(
                            context,
                            Routes.mealRecipe,
                            arguments: meal.idMeal!,
                          );
                        }
                      },
                      child: IgnorePointer(
                        ignoring: isLoading,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 250,
                          width: 160,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child:
                                    isLoading ||
                                        meal.strMealThumb == null ||
                                        meal.strMealThumb!.isEmpty
                                    ? Container(
                                        color: Colors.grey[300],
                                        width: double.infinity,
                                      )
                                    : Image.network(
                                        meal.strMealThumb!,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                      ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      isLoading ||
                                          meal.strMeal == null ||
                                          meal.strMeal!.isEmpty
                                      ? Container(
                                          height: 14,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        )
                                      : Text(meal.strMeal!),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
