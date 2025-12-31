import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/core/utils/app_textstyles.dart';
import 'package:e_commerce/features/presentation/widgets/app_bar_widget.dart';
import 'package:e_commerce/features/presentation/widgets/drawer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/presentation/bloc/bloc.dart';
import 'features/presentation/bloc/event.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {});
    });

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool showIcon = controller.text.isNotEmpty || _focusNode.hasFocus;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.card,
      drawer: DrawerWidgets(),
      appBar: AppBarWidget(),
      body: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              height: MediaQuery.of(context).size.height * 0.048,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context.read<ProductBloc>().add(SearchProductEvent(value));
                  }
                },
                controller: controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: AppStrings.hintText,
                  hintStyle: TextStyle(fontSize: 15, color: AppColors.textGrey),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.textDark),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.textDark),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      context.read<ProductBloc>().add(FetchProductsEvent());
                      controller.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: showIcon
                        ? Icon(Icons.close, color: Colors.black)
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: 40,

                            child: Icon(Icons.search, color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}
