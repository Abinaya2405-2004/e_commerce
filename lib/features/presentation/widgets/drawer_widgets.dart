import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/core/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class DrawerWidgets extends StatelessWidget {
  const DrawerWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
          ExpansionTile(

            title:  Text(AppStrings.lipStick,style: AppTextStyles.w500_16.copyWith(
                color: AppColors.textDark,fontSize: 18
            ),),
            children: [
              ListTile(
                title:  Text(AppStrings.mars,style: TextStyle(
                  color: Colors.black45
                )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:  Text(AppStrings.sugar,style: TextStyle(
                    color: Colors.black45
                )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),


          ExpansionTile(

            title:  Text(AppStrings.mascara,style: AppTextStyles.w500_16.copyWith(
                color: AppColors.textDark,fontSize: 18
            ),),
            children: [
              ListTile(
                title:  Text(AppStrings.kajal,style: TextStyle(
                    color: Colors.black45
                )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:  Text(AppStrings.albene,style: TextStyle(
                    color: Colors.black45
                )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          ExpansionTile(

            title:  Text(AppStrings.foundation,style: AppTextStyles.w500_16.copyWith(
                color: AppColors.textDark,fontSize: 18
            ),),
            children: [
              ListTile(
                title:  Text(AppStrings.plum,style: TextStyle(
                    color: Colors.black45
                )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:  Text(AppStrings.zudio,style: TextStyle(
                    color: Colors.black45
                )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
