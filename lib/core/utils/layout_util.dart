import 'package:flutter/material.dart';

class LayoutUtil {
  static bool isMobileLayout(BuildContext context) => MediaQuery.of(context).size.width < 600;
}
