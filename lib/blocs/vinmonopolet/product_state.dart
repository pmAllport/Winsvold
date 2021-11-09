import 'package:winsvold/models/reduced_product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductFailed extends ProductState {}

class ProductSuccess extends ProductState {
  final ReducedProduct reducedProduct;
  bool isQuantityView = false;

  ProductSuccess({required this.reducedProduct});

  @override
  List<Object> get props => [reducedProduct, isQuantityView];

  @override
  String toString() => 'Success { categories: $reducedProduct }';
}

class ProductInvalid extends ProductState {}
