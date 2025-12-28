import 'package:e_commerce/features/domain/usecase/serach_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/network/api_connection.dart';
import 'core/router/app_router.dart';
import 'features/data/data_source/product_datasource.dart';
import 'features/data/repository_impl/product_repoImpl.dart';
import 'features/domain/usecase/product_usecase.dart';
import 'features/presentation/bloc/bloc.dart';

void main() {
  final apiConnection = ApiConnection();

  final productRemoteDataSource =
  ProductRemoteDataSourceImpl(apiConnection);

  final productRepository =
  ProductRepositoryImpl(productRemoteDataSource);

  final getProductsUseCase =
  GetProductsUseCase(productRepository);
final searchProductUseCase=SearchProductsUseCase(productRepository);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(getProductsUseCase,searchProductUseCase),
        ),
      ],
      child:  MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
