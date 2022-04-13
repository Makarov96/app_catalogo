import 'package:app_catalogo/core/app_component.dart';
import 'package:app_catalogo/feature/ui/module_product.dart';
import 'package:app_catalogo/feature/ui/productdetail/screen/product_detail_screen.dart';
import 'package:app_catalogo/feature/ui/products/bloc/categorybloc/category_bloc.dart';
import 'package:app_catalogo/feature/ui/products/bloc/favoriteproductbloc/favorite_product_bloc.dart';
import 'package:app_catalogo/feature/ui/products/bloc/productbloc/product_bloc.dart';
import 'package:app_catalogo/feature/ui/products/screen/product_screen.dart';
import 'package:core_catalogo_module/feature/data/model/response/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: ModuleProduct.home,
      builder: (BuildContext context, GoRouterState state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                locator<CategoryBloc>()..add(CategoryInitialEvent()),
          ),
          BlocProvider(
            create: (context) =>
                locator<ProductBloc>()..add(ProductInitialEvent()),
          ),
          BlocProvider(
            create: (context) => locator<FavoriteProductBloc>(),
          )
        ],
        child: const ProductScreen(),
      ),
    ),
    GoRoute(
      path: ModuleProduct.productDetail,
      builder: (context, GoRouterState state) => ProdctDetailScreen(
        product: state.extra as Product,
      ),
    )
  ],
);
