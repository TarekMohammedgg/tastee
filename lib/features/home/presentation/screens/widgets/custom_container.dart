import 'package:flutter/material.dart';
import 'package:tastee/core/constants/app_colors.dart';
import 'package:tastee/core/constants/app_style.dart';

class CustomContainer extends StatelessWidget {
  final String image;
  final String title;

  const CustomContainer({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      width: 155,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.scaleDown,
          image: NetworkImage(image),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            AppColors.backgroundDark,
            Colors.black.withValues(alpha: 0.7),
            AppColors.surfaceDark,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: AppTextStyles.bold14.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
