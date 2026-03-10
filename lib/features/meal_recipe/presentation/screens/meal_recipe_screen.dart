import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tastee/core/constants/app_colors.dart';
import 'package:tastee/core/constants/app_style.dart';
import 'package:tastee/features/meal_recipe/data/models/recipe_model.dart';
import 'package:tastee/features/meal_recipe/presentation/cubit/recipe_cubit.dart';
import 'package:tastee/features/meal_recipe/presentation/cubit/recipe_states.dart';

class MealRecipeScreen extends StatefulWidget {
  final String mealId;

  const MealRecipeScreen({super.key, required this.mealId});

  @override
  State<MealRecipeScreen> createState() => _MealRecipeScreenState();
}

class _MealRecipeScreenState extends State<MealRecipeScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeCubit()..getRecipe(widget.mealId),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<RecipeCubit, RecipeStates>(
          builder: (context, state) {
            final isLoading = state is RecipeLoading || state is RecipeInitial;

            if (state is RecipeError) {
              return Center(child: Text(state.errorMessage));
            }

            final recipe = state is RecipeSuccess
                ? state.recipe
                : RecipeModel(
                    strMeal: "Loading Recipe Title",
                    strMealThumb: "",
                    strArea: "Loading",
                    strCategory: "Loading",
                    ingredients: [
                      "Loading ingredient 1",
                      "Loading ingredient 2",
                      "Loading ingredient 3",
                      "Loading ingredient 4",
                    ],
                  );

            return Skeletonizer(
              enabled: isLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        isLoading ||
                                recipe.strMealThumb == null ||
                                recipe.strMealThumb!.isEmpty
                            ? Container(
                                height: 350,
                                width: double.infinity,
                                color: Colors.grey[300],
                              )
                            : Image.network(
                                recipe.strMealThumb!,
                                height: 350,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: AppColors.primary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isFavorite = !isFavorite;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -2,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.strMeal ?? "",
                            style: AppTextStyles.bold24.copyWith(
                              fontSize: 26,
                              color: AppColors.backgroundDark,
                            ),
                          ),

                          const SizedBox(height: 30),
                          Text(
                            "Ingredients",
                            style: AppTextStyles.bold18.copyWith(
                              fontSize: 20,
                              color: AppColors.backgroundDark,
                            ),
                          ),
                          const SizedBox(height: 16),

                          ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recipe.ingredients.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.15,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      recipe.ingredients[index],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 30),
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
    );
  }
}
