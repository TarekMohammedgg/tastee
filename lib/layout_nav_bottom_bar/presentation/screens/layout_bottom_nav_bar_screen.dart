import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/core/constants/app_colors.dart';
import 'package:tastee/core/routing/routes.dart';
import 'package:tastee/layout_nav_bottom_bar/presentation/cubit/layout_states.dart'
    show LayoutBottomNavBarStates;

import '../cubit/layout_cubit.dart';

class LayoutBottomNavBarScreen extends StatefulWidget {
  const LayoutBottomNavBarScreen({super.key});

  @override
  State<LayoutBottomNavBarScreen> createState() =>
      _LayoutBottomNavBarScreenState();
}

class _LayoutBottomNavBarScreenState extends State<LayoutBottomNavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutBottomNavBarStates>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              if (context.read<LayoutCubit>().currentIndex != 0) {
                context.read<LayoutCubit>().changeIndex(0);
              } else {
                Navigator.pushNamed(context, Routes.home);
              }
            },
            child: Scaffold(
              body: context
                  .read<LayoutCubit>()
                  .screens[context.read<LayoutCubit>().currentIndex],
              bottomNavigationBar: ClipPath(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: BottomNavigationBar(
                    currentIndex: context.read<LayoutCubit>().currentIndex,
                    onTap: (index) {
                      context.read<LayoutCubit>().changeIndex(index);
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    selectedItemColor: AppColors.primary,
                    unselectedItemColor: Colors.grey,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: "Favourite",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: "Profile",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
