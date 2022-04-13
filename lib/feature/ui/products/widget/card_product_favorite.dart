import 'package:app_catalogo/feature/ui/products/widget/image_product.dart';
import 'package:core_catalogo_module/feature/data/model/response/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CardProductFavorite extends StatelessWidget {
  const CardProductFavorite({
    Key? key,
    required this.product,
    this.onTAp,
  }) : super(key: key);

  final Product product;
  final void Function()? onTAp;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTAp,
      child: Card(
        elevation: 3,
        child: SizedBox(
          height: 120.h,
          width: double.infinity,
          child: Row(
            children: [
              ImageProduct(
                path: product.productImage,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ).copyWith(
                    top: 10.h,
                  ),
                  child: Column(
                    children: [
                      Text(
                        product.productName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.label_outline_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            product.productPrice,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (!await launch(product.urlMoreDetail)) {
                            throw 'Could not launch $product.urlMoreDetail';
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.link,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'More details',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          //child: ,
        ),
      ),
    );
  }
}
