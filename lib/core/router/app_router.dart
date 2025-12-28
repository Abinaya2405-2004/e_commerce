import 'package:e_commerce/features/presentation/screens/product_screen_001v1.dart' show ProductScreen001v1;
import 'package:go_router/go_router.dart';

import '../../features/presentation/screens/product_screen_001v1.dart';
import '../../main_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/main',
  routes: [
    GoRoute(
      path: '/main',
      builder: (context, state) {
        return MainScreen(child: ProductScreen001v1());
      },
    ),
  ],
);
