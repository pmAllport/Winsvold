import 'package:flutter/material.dart';
import 'package:winsvold/models/reduced_product.dart';

class ProductArguments {
  final List<List<int>> productList;
  ProductArguments({required this.productList});
}

class AmountArguments {
  final Map<UniqueKey, ReducedProduct> reducedProductMap;
  AmountArguments({required this.reducedProductMap});
}

// These are techincally the same as AmountArguments, but is created to ensure further development
class SummaryArguments {
  final Map<UniqueKey, ReducedProduct> reducedProductMap;
  SummaryArguments({required this.reducedProductMap});
}

class SettingsArguments {
  SettingsArguments();
}
