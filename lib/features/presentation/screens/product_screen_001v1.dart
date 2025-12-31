import 'dart:async';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:e_commerce/core/utils/app_strings.dart';
import 'package:e_commerce/core/utils/app_textstyles.dart';

import 'package:e_commerce/features/presentation/widgets/commom_textbutton_widget.dart';
import 'package:e_commerce/features/presentation/widgets/section_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entity/product_entity.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';
import '../widgets/app_divider_widget.dart';
import '../widgets/expansion_widget.dart';
import '../widgets/horizontal_product_widget.dart';

class ProductScreen001v1 extends StatefulWidget {
  const ProductScreen001v1({super.key});

  @override
  State<ProductScreen001v1> createState() => _ProductScreen001v1State();
}

class _ProductScreen001v1State extends State<ProductScreen001v1> {
  int selectedIndex = -1;

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final FocusNode _focusNode = FocusNode();
  final List<String> sliderImages = [
    AppImages.lipstick,
    AppImages.foundation,
    AppImages.mascara,
    AppImages.cosmetics,
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProductsEvent());
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        if (_currentPage < sliderImages.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  List<String> extractCategories(List<ProductEntity> products) {
    return products.map((e) => e.category).toSet().toList();
  }

  final List<String> images = [
    AppImages.lipAd,
    AppImages.perfume,
    AppImages.furniture,
    AppImages.grocery,
  ];
  final List<String> Texts = [
    AppStrings.makeUp,
    AppStrings.scent,
    AppStrings.table,
    AppStrings.gro,
  ];

  @override
  void dispose() {
    _focusNode.dispose();
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductError) {
            return Center(child: Text(state.message));
          }

          if (state is ProductLoaded) {
            final products = state.products;
            final categories = extractCategories(products);

            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: sliderImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              sliderImages[index],
                              width: double.infinity,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: const SizedBox(height: 10)),

                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      sliderImages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 8 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.grey
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                AppDividerWidget(),

                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final isSelected = selectedIndex == index;

                    return CommonSliverItem(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });

                        context.go('/product2?category=${categories[index]}');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.border,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            categories[index].toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? Colors.red
                                  : AppColors.textDark,
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: categories.length),
                ),

                SectionTitleWidget(
                  title: 'JUST LANDED',
                  style: TextStyle(fontSize: 22),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 0,
                                childAspectRatio: 1.3,
                              ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];

                            return HorizontalProductWidget(
                              product: products[index],
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SectionTitleWidget(
                  title: 'TRENDING NOW',
                  style: TextStyle(fontSize: 22),
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return CommonSliverItem(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        context.go('/product2?category=${categories[index]}');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(17.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                                child: Image.asset(
                                  images[index],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                Texts[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }, childCount: categories.length),
                ),

                buildExpansionTile(
                  title: AppStrings.about,
                  content:
                      'About sephora\nPrivacy Policy\nTerms of Use\nSitemap',
                ),

                buildExpansionTile(
                  title: AppStrings.customer,
                  content: 'FAQ\nDelivery\nFind a Store\nBeauty Service',
                ),
                AppDividerWidget(),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'CONNECT WITH US',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AppImages.insta, height: 25, width: 5),
                        SvgPicture.asset(
                          AppImages.youTube,
                          height: 25,
                          width: 5,
                        ),
                        SvgPicture.asset(
                          AppImages.twitter,
                          height: 25,
                          width: 5,
                        ),
                        SvgPicture.asset(
                          AppImages.faceBook,
                          height: 25,
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'PAYMENT OPTIONS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AppImages.visa, height: 35, width: 15),
                        SvgPicture.asset(
                          AppImages.master,
                          height: 35,
                          width: 15,
                        ),
                        SvgPicture.asset(AppImages.amex, height: 35, width: 15),
                      ],
                    ),
                  ),
                ),
                AppDividerWidget(),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        '@ 2025 Sephora India',
                        style: AppTextStyles.w500_16.copyWith(
                          color: AppColors.textGrey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
