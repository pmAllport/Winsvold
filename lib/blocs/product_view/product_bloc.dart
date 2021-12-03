import 'dart:developer';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:winsvold/blocs/product_view/product_bucket.dart';
import 'package:winsvold/models/reduced_product.dart';
import 'package:winsvold/data/product_repository.dart';
import 'package:http/http.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductLoading()) {
    on<ProductRequested>(_onProductRequested);
  }

  void _onProductRequested(
      ProductRequested event, Emitter<ProductState> emit) async {
    Client client = Client();
    StreamedResponse? productResponse;
    emit(ProductLoading());
    try {
      try {
        productResponse = await repository.fetchProduct(
            productId: event.productId, client: client);

        // This means that the product failed to fetch;
      } catch (e, stacktrace) {
        debugPrint(e.toString());
        emit(ProductInvalid());
      }
      late Response completeResponse;
      if (productResponse == null) {
        emit(ProductInvalid());
        client.close();
      } else {
        completeResponse = await Response.fromStream(productResponse);
        client.close();
        try {
          emit(ProductSuccess(
              reducedProduct:
                  ReducedProduct.fromJson(jsonDecode(completeResponse.body))));

          // This means that the product failed to create a model from the json body. Probably a bad json from an outphased product.
        } catch (e, stacktrace) {
          debugPrint(e.toString());
          emit(ProductInvalid());
        }
      }
    } catch (e, stackTrace) {
      emit(ProductFailed());
    }
  }
}
