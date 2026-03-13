import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tastee/core/constants/app_colors.dart';
import 'package:tastee/core/constants/app_style.dart';
import 'package:tastee/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tastee/features/favourite/presentation/cubit/favourite_states.dart';
import 'package:tastee/features/meal_recipe/data/models/recipe_model.dart';
import 'package:tastee/features/meal_recipe/presentation/cubit/recipe_cubit.dart';
import 'package:tastee/features/meal_recipe/presentation/cubit/recipe_states.dart';
import 'package:tastee/features/meals/data/models/meal_model.dart';

class MealRecipeScreen extends StatefulWidget {
  final String mealId;

  const MealRecipeScreen({super.key, required this.mealId});

  @override
  State<MealRecipeScreen> createState() => _MealRecipeScreenState();
}

class _MealRecipeScreenState extends State<MealRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;

    return BlocProvider(
      create: (context) => RecipeCubit()..getRecipe(widget.mealId),
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: BlocBuilder<RecipeCubit, RecipeStates>(
          builder: (context, state) {
            final isLoading = state is RecipeLoading || state is RecipeInitial;

            if (state is RecipeError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline,
                          size: 48, color: colorScheme.error),
                      const SizedBox(height: 16),
                      Text(
                        state.errorMessage,
                        style: AppTextStyles.semiBold14.copyWith(
                          color: colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () => context
                            .read<RecipeCubit>()
                            .getRecipe(widget.mealId),
                        icon: const Icon(Icons.refresh),
                        label: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
              );
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
                                color: colorScheme.surfaceContainerHighest,
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
                                  backgroundColor:
                                      scaffoldColor.withValues(alpha: 0.85),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: colorScheme.onSurface,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                BlocBuilder<FavouriteCubit, FavouriteStates>(
                                  builder: (context, favState) {
                                    final isFav = context
                                        .read<FavouriteCubit>()
                                        .isFavourite(widget.mealId);
                                    return CircleAvatar(
                                      backgroundColor:
                                          scaffoldColor.withValues(alpha: 0.85),
                                      child: IconButton(
                                        icon: AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 250),
                                          transitionBuilder: (child, anim) =>
                                              ScaleTransition(
                                                  scale: anim, child: child),
                                          child: Icon(
                                            isFav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            key: ValueKey(isFav),
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        onPressed: () {
                                          context
                                              .read<FavouriteCubit>()
                                              .toggleFavourite(
                                                MealModel(
                                                  idMeal: widget.mealId,
                                                  strMeal: recipe.strMeal,
                                                  strMealThumb:
                                                      recipe.strMealThumb,
                                                ),
                                              );
                                        },
                                      ),
                                    );
                                  },
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
                            decoration: BoxDecoration(
                              color: scaffoldColor,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      color: scaffoldColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.strMeal ?? "",
                            style: AppTextStyles.bold24.copyWith(
                              fontSize: 26,
                              color: colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 30),
                          Text(
                            "Ingredients",
                            style: AppTextStyles.bold18.copyWith(
                              fontSize: 20,
                              color: colorScheme.onSurface,
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
                                        color: colorScheme.onSurface
                                            .withValues(alpha: 0.7),
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
