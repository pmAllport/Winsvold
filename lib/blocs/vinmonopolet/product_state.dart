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

  ProductSuccess({required this.reducedProduct});

  @override
  List<Object> get props => [reducedProduct];

  @override
  String toString() => 'Success { categories: $reducedProduct }';
}

class ProductInvalid extends ProductState {}
