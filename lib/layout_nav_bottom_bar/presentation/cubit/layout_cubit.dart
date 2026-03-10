import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/features/home/presentation/screens/home_screen.dart';
import 'package:tastee/layout_nav_bottom_bar/presentation/cubit/layout_states.dart';

class LayoutCubit extends Cubit<LayoutBottomNavBarStates> {
  LayoutCubit() : super(InitialLayoutBottomNavBarState());
  int currentIndex = 0;
  List<Widget> screens = [HomeScreen(), HomeScreen(), HomeScreen()];
  changeIndex(int index) {
    currentIndex = index;
    emit(ChangeLayoutBottomNavBarState());
  }
}
