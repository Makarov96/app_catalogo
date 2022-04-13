import 'package:app_catalogo/feature/ui/products/bloc/categorybloc/category_bloc.dart';
import 'package:app_catalogo/feature/ui/products/bloc/productbloc/product_bloc.dart';
import 'package:core_catalogo_module/feature/data/model/response/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    Key? key,
    required this.categories,
  }) : super(key: key);
  final List<ProductCategory> categories;
  @override
  State<CustomTabBar> createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late final TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: widget.categories.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _controller,
      indicatorColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      onTap: (onTap) {
        context.read<CategoryBloc>().add(
              CategoryRefreshlEvent(
                CategoryModel(listProductCategory: widget.categories),
              ),
            );
        if (onTap == 0) {
          context.read<ProductBloc>().add(
                (const GetProductEvent(5, 0)),
              );
          return;
        }

        context.read<ProductBloc>().add(
              (ProductFilterByTagEvent(widget.categories[onTap].id as int)),
            );
      },
      tabs: List.generate(
        _controller.length,
        (index) => Container(
          width: 200,
          height: 40,
          child: Center(
            child: Text(
              widget.categories[index].description,
              style: TextStyle(
                color: index == _controller.index ? Colors.white : Colors.black,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: index == _controller.index ? 2 : 1,
              color: index == _controller.index
                  ? Colors.black
                  : Colors.grey.withOpacity(0.1),
            ),
            color: index == _controller.index
                ? Colors.black
                : Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
