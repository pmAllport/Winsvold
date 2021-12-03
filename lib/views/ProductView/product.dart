import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/product_view/product_bucket.dart';
import 'package:winsvold/models/reduced_product.dart';
import 'package:winsvold/views/ProductView/product_invalid.dart';
import 'package:winsvold/views/ProductView/product_view_tile.dart';

class Product extends StatefulWidget {
  final int productId;
  final Map<UniqueKey, ReducedProduct> reducedProductMap;
  const Product({
    required this.productId,
    required this.reducedProductMap,
    Key? key,
  }) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> with AutomaticKeepAliveClientMixin {
  late ProductBloc _productBlocProvider;
  late int productId;
  final UniqueKey productKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    productId = widget.productId;
    _productBlocProvider = BlocProvider.of<ProductBloc>(context);
    _productBlocProvider.add(ProductRequested(productId: productId));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Card(
                borderOnForeground: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 15.0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: stateSelector(state, context)),
                ),
              ),
            ));
      },
    );
  }

  Widget stateSelector(ProductState state, BuildContext context) {
    if (state is ProductLoading) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 340,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
                Text(
                  "Laster inn produkt",
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
          )
        ],
      ));
    } else if (state is ProductSuccess) {
      widget.reducedProductMap[productKey] = state.reducedProduct;
      return ProductViewTile(
        reducedProduct: state.reducedProduct,
        context: context,
      );
    } else if (state is ProductInvalid) {
      return ProductInvalidTile(
        context: context,
      );
    } else {
      return const Text("Neither Productloading or productsuccess");
    }
  }

  @override
  bool get wantKeepAlive => true;
}
