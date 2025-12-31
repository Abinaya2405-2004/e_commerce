import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';

SliverToBoxAdapter buildExpansionTile({
  required String title,
  required String content,
}) {
  return SliverToBoxAdapter(
    child: ExpansionTile(
      splashColor: Colors.transparent,
      backgroundColor: AppColors.card,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              content,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}
