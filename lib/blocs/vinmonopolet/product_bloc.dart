import 'dart:developer';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:winsvold/blocs/vinmonopolet/product_bucket.dart';
// We set "category" as cat, due to that "Category" is a protected term in Flutter.
import 'package:winsvold/models/reduced_product.dart';
import 'package:winsvold/data/product_repository.dart';
import 'package:http/http.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductRequested) {
      Client client = Client();
      StreamedResponse? productResponse;
      yield ProductLoading();
      try {
        try {
          productResponse = await repository.fetchProduct(
              productId: event.productId, client: client);

          // This means that the product failed to fetch;
        } catch (e, stacktrace) {
          debugPrint(e.toString());
          yield ProductInvalid();
        }
        late Response completeResponse;
        if (productResponse == null) {
          yield ProductInvalid();
          client.close();
        } else {
          completeResponse = await Response.fromStream(productResponse);
          client.close();
          try {
            yield (ProductSuccess(
                reducedProduct: ReducedProduct.fromJson(
                    jsonDecode(completeResponse.body))));

            // This means that the product failed to create a model from the json body. Probably a bad json from an outphased product.
          } catch (e, stacktrace) {
            debugPrint(e.toString());
            yield ProductInvalid();
          }
        }
      } catch (e, stackTrace) {
        yield ProductFailed();
      }
    } else {
      yield ProductFailed();
    }
  }
}
