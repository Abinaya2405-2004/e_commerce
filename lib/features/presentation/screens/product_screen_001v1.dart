import 'dart:async';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';

class ProductScreen001v1 extends StatefulWidget {
  const ProductScreen001v1({super.key});

  @override
  State<ProductScreen001v1> createState() => _ProductScreen001v1State();
}

class _ProductScreen001v1State extends State<ProductScreen001v1> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

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
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: _pageController,
              itemCount: sliderImages.length,
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

          SizedBox(height: 16),
          Expanded(
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

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.5,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                                child: Image.network(
                                  product.image,
                                  height: 200,
                                  width: double.infinity,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.image),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${product.price}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product.description,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.expand();
              },
            ),
          ),
        ],
      ),
    );
  }
}
