import 'package:app_catalogo/feature/ui/module_product.dart';
import 'package:core_catalogo_module/feature/data/model/response/product_model.dart';
import 'package:dst_catalogo_module/base/basewidget/base_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ProdctDetailScreen extends StatelessWidget {
  const ProdctDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 300.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      product.productImage,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ProductDetailLayout(product: product),
              )
            ],
          ),
          const CustomAppBar(),
        ],
      ),
    );
  }
}

class ProductDetailLayout extends StatelessWidget {
  const ProductDetailLayout({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '${product.productPrice}',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
                  textAlign: TextAlign.left,
                ),
                const Icon(Icons.favorite_rounded)
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              product.productDescription,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.sp),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 50.h,
            ),
            ElevatedButton(
              onPressed: () async {
                if (!await launch(product.urlMoreDetail)) {
                  throw 'Could not launch $product.urlMoreDetail';
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.sp))),
              child: SizedBox(
                width: 200.w,
                height: 30.h,
                child: Center(
                  child: Text(
                    'More Details',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(20.sp),
        child: IconButton(
          onPressed: () => context.go(ModuleProduct.home),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
