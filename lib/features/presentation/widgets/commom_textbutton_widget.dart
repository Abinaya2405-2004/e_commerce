import 'package:flutter/material.dart';

class CommonSliverItem extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final EdgeInsets outerPadding;
  final EdgeInsets buttonPadding;

  const CommonSliverItem({
    super.key,
    required this.onTap,
    required this.child,
    this.outerPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    this.buttonPadding = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: outerPadding,
        child: TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            padding: MaterialStateProperty.all(buttonPadding),
            alignment: Alignment.centerLeft,
          ),
          child: child,
        ),
      ),
    );
  }
}
