import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../config/colors.dart';
import '../config/constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.title,
    this.onTap,
    required this.actions,
  });

  final String title;
  final void Function()? onTap;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      decoration: const BoxDecoration(
        color: primaryColor,
      ),
      child: Row(
        children: [
          // back button
          GestureDetector(
            onTap: onTap ?? () => Get.back(),
            child: Image.asset(
              'assets/images/chevron-right.png',
              height: 2.5.h,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          // title
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: textColorWhite,
              overflow: TextOverflow.clip,
              fontSize: Adaptive.sp(18),
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Row(
            children: actions ?? const [],
          ),
        ],
      ),
    );
  }
}
