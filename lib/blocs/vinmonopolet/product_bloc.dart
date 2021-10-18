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
      yield ProductLoading();
      try {
        try {
          Client client = Client();
          StreamedResponse? productResponse = await repository.fetchProduct(
              productId: event.productId, client: client);

          if (productResponse == null) {
            yield ProductInvalid();
            client.close();
          } else {
            Response completeResponse =
                await Response.fromStream(productResponse);
            client.close();

            yield (ProductSuccess(
                reducedProduct: ReducedProduct.fromJson(
                    jsonDecode(completeResponse.body))));
          }
        } catch (e, stacktrace) {
          debugPrint(e.toString());
          yield ProductFailed();
        }
      } catch (e, stackTrace) {
        yield ProductFailed();
      }
    } else {
      yield ProductFailed();
    }
  }
}
