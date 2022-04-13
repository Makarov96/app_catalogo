import 'dart:io';

import 'package:app_catalogo/feature/ui/module_product.dart';
import 'package:app_catalogo/feature/ui/products/bloc/favoriteproductbloc/favorite_product_bloc.dart';
import 'package:app_catalogo/feature/ui/products/widget/card_product_favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BaseBottomSheet {
  static Future<void> showBottomSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext contextM) => BlocProvider.value(
        value: BlocProvider.of<FavoriteProductBloc>(context)
          ..add(GetFavoriteProductEvent()),
        child: const MyCustomModal(),
      ),
    );
  }
}

class MyCustomModal extends StatelessWidget {
  const MyCustomModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 0.5,
      color: Colors.white,
      child: BlocBuilder<FavoriteProductBloc, FavoriteProductState>(
        builder: (context, state) {
          if (state is FavoriteProductLoadingState) {
            return Platform.isIOS
                ? const CupertinoActivityIndicator()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 160.w,
                      vertical: 175.h,
                    ),
                    child: const CircularProgressIndicator(),
                  );
          } else if (state is FavoriteProductLoadedState) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ).copyWith(
                bottom: 80.h,
              ),
              itemCount: state.productModel.length,
              itemBuilder: (context, favoriteIndex) {
                final product = state.productModel[favoriteIndex];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 20.w,
                  ),
                  child: CardProductFavorite(
                    product: product,
                    onTAp: () => context.go(
                      ModuleProduct.productDetail,
                      extra: product,
                    ),
                  ),
                );
              },
            );
          } else if (state is FavoriteProductErrorState) {
            return Platform.isIOS
                ? const CupertinoActivityIndicator()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 160.w,
                      vertical: 175.h,
                    ),
                    child: const CircularProgressIndicator(),
                  );
          } else {
            return Platform.isIOS
                ? const CupertinoActivityIndicator()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 160.w,
                      vertical: 175.h,
                    ),
                    child: const CircularProgressIndicator(),
                  );
          }
        },
      ),
    );
  }
}
