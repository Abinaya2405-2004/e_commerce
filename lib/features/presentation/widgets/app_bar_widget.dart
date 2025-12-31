import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/app_textstyles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.card,
      centerTitle: true,
      title: Text(
        AppStrings.sephora,
        style: AppTextStyles.w600_32.copyWith(
          wordSpacing: 20.7,
          letterSpacing: 5,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Row(
            children: [
              Icon(Icons.person_2_outlined, color: AppColors.textDark),
              SizedBox(width: 8),
              Icon(Icons.shopping_bag_outlined, color: AppColors.textDark),
              SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
