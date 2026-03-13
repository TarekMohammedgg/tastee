import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/core/constants/app_colors.dart';
import 'package:tastee/core/constants/app_strings.dart';
import 'package:tastee/core/constants/app_style.dart';
import 'package:tastee/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tastee/features/favourite/presentation/cubit/favourite_states.dart';
import 'package:tastee/features/favourite/presentation/screens/widgets/favourite_meal_card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.favouriteTitle, style: AppTextStyles.bold18),
      ),
      body: BlocBuilder<FavouriteCubit, FavouriteStates>(
        builder: (context, state) {
          final favourites = context.read<FavouriteCubit>().getFavourites();

          if (favourites.isEmpty) {
            return _buildEmptyState();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: GridView.builder(
              itemCount: favourites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 155 / 176,
              ),
              itemBuilder: (context, index) {
                return FavouriteMealCard(meal: favourites[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: AppColors.primary.withValues(alpha: 0.4)),
          const SizedBox(height: 16),
          Text(AppStrings.favouriteEmptyTitle, style: AppTextStyles.bold18),
          const SizedBox(height: 8),
          Text(
            AppStrings.favouriteEmptySubtitle,
            style: AppTextStyles.regular16.copyWith(color: AppColors.textGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
