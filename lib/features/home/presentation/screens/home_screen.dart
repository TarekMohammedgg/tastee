import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tastee/core/constants/app_colors.dart';
import 'package:tastee/core/constants/app_strings.dart';
import 'package:tastee/core/constants/app_style.dart';
import 'package:tastee/core/routing/routes.dart';
import 'package:tastee/features/home/data/models/category_model.dart';
import 'package:tastee/features/home/presentation/cubit/home_cubit.dart';
import 'package:tastee/features/home/presentation/cubit/home_states.dart';
import 'package:tastee/features/home/presentation/screens/widgets/custom_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          AppStrings.recipeFinderTitle,
          style: AppTextStyles.bold20.copyWith(color: AppColors.surfaceDark),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: AppColors.primary),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..getCategories(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.categoriesTitle,
                      style: AppTextStyles.bold18.copyWith(
                        color: AppColors.backgroundDark,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.seeAll,
                        style: AppTextStyles.semiBold14.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  final isLoading = state is HomeLoading;

                  if (state is HomeError) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(state.errorMessage)),
                    );
                  }

                  final categories = state is HomeSuccess
                      ? state.categories
                      : List.generate(
                          6,
                          (index) => CategoryModel(
                            strCategory: 'Loading',
                            strCategoryThumb: '',
                          ),
                        );

                  return SliverSkeletonizer(
                    enabled: isLoading,
                    child: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final category = categories[index];

                        return GestureDetector(
                          onTap: () {
                            if (!isLoading) {
                              Navigator.pushNamed(
                                context,
                                Routes.meals,
                                arguments: category.strCategory ?? '',
                              );
                            }
                          },
                          child: IgnorePointer(
                            ignoring: isLoading,
                            child: CustomContainer(
                              isLoading: isLoading,
                              gradientColor: isLoading
                                  ? LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.grey.withValues(alpha: 0.5),
                                      ],
                                    )
                                  : LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        AppColors.backgroundDark,
                                        Colors.black.withValues(alpha: 0.7),
                                        AppColors.surfaceDark,
                                      ],
                                    ),
                              image: category.strCategoryThumb ?? '',
                              title: category.strCategory ?? '',
                            ),
                          ),
                        );
                      }, childCount: categories.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 155 / 176,
                          ),
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
