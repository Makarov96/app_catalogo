import 'package:app_catalogo/feature/ui/products/bloc/productbloc/product_bloc.dart';
import 'package:app_catalogo/feature/ui/products/widget/category_widget.dart';
import 'package:app_catalogo/feature/ui/products/widget/product_widget.dart';
import 'package:core_catalogo_module/core/helper/debonce_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dst_catalogo_module/base/basewidget/base_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreLayout extends StatefulWidget {
  const StoreLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<StoreLayout> createState() => _StoreLayoutState();
}

class _StoreLayoutState extends State<StoreLayout> {
  late final TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: context.watch<ProductBloc>().scrollcontroller,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(top: 10.sp),
          sliver: SliverAppBar(
            flexibleSpace: SizedBox(
              height: 55,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: BaseInput(
                  controller: _textController,
                  hintText: 'Ingrese producto a buscar',
                  onChanged: (productName) {
                    final deboncer = Debounce(milliseconds: 1500);
                    deboncer.run(
                      () => context.read<ProductBloc>().add(
                            ProductFilterByNameEvent(productName),
                          ),
                    );
                  },
                  onPressed: () {
                    _textController.clear();
                    context.read<ProductBloc>().add(ProductInitialEvent());
                  },
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            context.read<ProductBloc>().add(ProductInitialEvent());
          },
        ),
        const SliverToBoxAdapter(
          child: CategoryWidget(),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(bottom: 100),
          sliver: const ProductWidget(),
        )
      ],
    );
  }
}
