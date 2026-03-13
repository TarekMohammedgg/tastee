import 'package:flutter/material.dart';
import 'package:tastee/core/constants/app_style.dart';

class CustomContainer extends StatelessWidget {
  final String image;
  final String title;
  final LinearGradient gradientColor;
  final bool isLoading;
  const CustomContainer({
    super.key,
    required this.image,
    required this.title,
    required this.gradientColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        clipBehavior: Clip.antiAlias,
        height: 160,
        width: 155,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(color: Colors.grey[300], width: double.infinity),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 14,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      height: 160,
      width: 155,
      decoration: BoxDecoration(
        gradient: gradientColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          image.isEmpty
              ? Container(color: Colors.grey)
              : Image.network(image, fit: BoxFit.fill),
          Positioned(
            left: 5,
            bottom: 10,
            right: 5,

            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withValues(alpha: 0.2),
                    blurRadius: 5,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Text(
                maxLines: 2,
                title,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bold14.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
