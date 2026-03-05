import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarSlider extends StatelessWidget {
  final List<String> avatars;
  final int selectedAvatarIndex;
  final Function(int, CarouselPageChangedReason) onPageChanged;
  const AvatarSlider(
      {super.key,
      required this.avatars,
      required this.selectedAvatarIndex,
      required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: avatars.length,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(90.r),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              avatars[index],
              fit: BoxFit.fitHeight,
            ));
      },
      options: CarouselOptions(
        height: 150.h,
        viewportFraction: 0.4,
        initialPage: selectedAvatarIndex,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
