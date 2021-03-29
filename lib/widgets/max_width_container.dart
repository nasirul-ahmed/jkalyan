import 'package:devbynasirulahmed/constants/breakpoints.dart';
import 'package:flutter/material.dart';

class MaxWidthContainer extends StatelessWidget {
  final Widget child;

  const MaxWidthContainer({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        child: child,
        constraints: const BoxConstraints(maxWidth: kMaxWidth),
      ),
    );
  }
}
