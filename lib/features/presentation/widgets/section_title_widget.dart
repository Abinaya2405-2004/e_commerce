import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  final double top;
  final double bottom;
  final TextStyle style;

  const SectionTitleWidget({
    super.key,
    required this.title,
    required this.style,
    this.top = 17,
    this.bottom = 6,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: top, bottom: bottom),
        child: Center(child: Text(title, style: style)),
      ),
    );
  }
}
