import 'package:devbynasirulahmed/constants/breakpoints.dart';
import 'package:flutter/material.dart';

class Responsivelayout extends StatelessWidget {
  const Responsivelayout({
    Key? key,
    required this.mobileView,
    this.tabletView,
    this.desktopView,
  }) : super(key: key);
  final Widget mobileView;
  final Widget? tabletView;
  final Widget? desktopView;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth < ktabletView) {
        return mobileView;
      } else if (constraint.maxWidth > kmobileView &&
          constraint.maxWidth < kdesktopView) {
        return tabletView ?? mobileView;
      } else {
        return desktopView ?? mobileView;
      }
    });
  }
}
