import 'package:flutter/material.dart';

import '../constant/colors.dart';

class CustomFloatingButton extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onTap;
  const CustomFloatingButton(
      {super.key, required this.title, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed:onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [child, Text(title)],
        ));
  }
}
