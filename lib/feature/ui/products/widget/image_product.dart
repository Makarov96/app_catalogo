import 'package:app_catalogo/feature/ui/module_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageProduct extends StatelessWidget {
  const ImageProduct({
    Key? key,
    required this.path,
  }) : super(key: key);
  final String path;
  @override
  Widget build(BuildContext context) {
    var _renderNetworkImage = true;
    if (path.isEmpty) {
      _renderNetworkImage = false;
    }
    return _renderNetworkImage
        ? Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(path),
            )),
          )
        : Container(
            width: 100.w,
            height: 100.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(ModuleProduct.imageAvali),
            )),
          );
  }
}
