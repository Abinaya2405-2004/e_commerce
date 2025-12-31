import 'package:flutter/material.dart';

class AppDividerWidget extends StatelessWidget {
  final double horizontal;
  final double vertical;

  const AppDividerWidget({super.key, this.horizontal = 8, this.vertical = 8});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
      ),
    );
  }
}
