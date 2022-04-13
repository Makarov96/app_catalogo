import 'dart:io';

import 'package:app_catalogo/feature/ui/module_product.dart';
import 'package:app_catalogo/feature/ui/products/bloc/productbloc/product_bloc.dart';
import 'package:app_catalogo/feature/ui/products/widget/custom_bottom_sheet.dart';
import 'package:dst_catalogo_module/base/basealerts/basedialog/alert_dialog_type.dart';
import 'package:dst_catalogo_module/base/basewidget/base_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          previous != current && current is ProductLoadedState,
      listener: (context, state) async {
        if (state is ProductLoadingState) {
          await BaseDialog.showAlertDialog(context, AlertDialogType.loading);
        } else if (state is ProductSearchByNameState) {
          const snackBar = SnackBar(
            content: Text('Buscando ...'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is ProductLoadedState) {
          if (state.ineedApplyPop) {
            Navigator.pop(context);
          }
        } else if (state is ProductSetFavoriteProductState) {
          Navigator.pop(context);
          if (state.status) {
            await BaseDialog.showAlertDialog(
              context,
              AlertDialogType.success,
              callback: () {
                Navigator.pop(context);
                BaseBottomSheet.showBottomSheet(context);
              },
            );
          }
        }
      },
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return SliverToBoxAdapter(
            child: Platform.isIOS
                ? const CupertinoActivityIndicator()
                : const Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                  ),
          );
        } else if (state is ProductErrorState) {
          return SliverToBoxAdapter(
            child: Platform.isIOS
                ? const CupertinoActivityIndicator()
                : const Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                  ),
          );
        } else if (state is ProductLoadedState) {
          return SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 0.6,
            children: state.productModel.map((product) {
              return GestureDetector(
                onTap: () => context.go(
                  ModuleProduct.productDetail,
                  extra: product,
                ),
                child: Card(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  product.productImage,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0)
                                .copyWith(
                              top: 10,
                            ),
                            child: Text(
                              product.productName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              splashRadius: 30.sp,
                              icon: Icon(
                                product.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: product.isFavorite
                                    ? Colors.redAccent
                                    : Colors.black,
                              ),
                              onPressed: () => context.read<ProductBloc>().add(
                                    ProductFavoriteSetEvent(
                                      product.id,
                                      !product.isFavorite,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          return SliverToBoxAdapter(
            child: Center(
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator()
                  : const Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
        }
      },
    );
  }
}
