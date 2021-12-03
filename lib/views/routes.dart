import 'package:flutter/material.dart';
import 'package:winsvold/utils/navigator_arguments.dart';
import 'package:winsvold/views/AmountView/amount_list_view.dart';
import 'package:winsvold/views/ProductView/product_list.dart';
import 'package:winsvold/views/summary_view/summary_list.dart';

class ExtractProductList extends StatelessWidget {
  static const routeName = '/productList';
  const ExtractProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductArguments;

    return ProductList(productList: args.productList);
  }
}

class ExtractAmountList extends StatelessWidget {
  static const routeName = '/amountList';
  const ExtractAmountList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AmountArguments;

    return AmountList(reducedProductMap: args.reducedProductMap);
  }
}

class ExtractSummaryList extends StatelessWidget {
  static const routeName = '/summaryList';
  const ExtractSummaryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SummaryArguments;

    return SummaryListView(reducedProductMap: args.reducedProductMap);
  }
}
