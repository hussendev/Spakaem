// ignore_for_file: camel_case_extensions, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension sizedBoxExtension on int {
  Widget ph() => SizedBox(
        height: this.h,
      );
  Widget pw(double width) => SizedBox(
        width: this.w,
      );
}
