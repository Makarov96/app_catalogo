import 'package:app_catalogo/feature/ui/products/widget/custom_bottom_sheet.dart';
import 'package:app_catalogo/feature/ui/products/widget/layout/product_screen_layout.dart';
import 'package:dst_catalogo_module/base/basewidget/base_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      child: SafeArea(
        child: StoreLayout(),
      ),
      floatingActionButton: _CustomFloatingButton(),
    );
  }
}

class _CustomFloatingButton extends StatelessWidget {
  const _CustomFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () => BaseBottomSheet.showBottomSheet(context),
      child: const Center(
        child: Icon(
          Icons.filter_none_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
