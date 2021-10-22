import 'package:catch_the_monkey/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  String text;
  Color textColor;
  Color backgroundColor;
  Color borderColor;
  Function() onTap;

  Button(this.text, this.onTap,
      {this.textColor = AppColors.black,
      this.backgroundColor = AppColors.yellow,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: borderColor),
        ),
        width: double.infinity,
        margin: const EdgeInsets.only(left: 19, right: 19),
        padding: EdgeInsets.only(top: 17.h, bottom: 17.h),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(fontSize: 18.sp, color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
