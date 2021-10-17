import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/vinmonopolet/product_bucket.dart';
import 'package:winsvold/views/Product/product_tile.dart';

class Product extends StatefulWidget {
  final int productId;
  const Product({
    required int productId,
    Key? key,
    // ignore: prefer_initializing_formals
  })  : productId = productId,
        super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> with AutomaticKeepAliveClientMixin {
  late ProductBloc _vmpBlocProvider;
  late int productId;

  @override
  void initState() {
    super.initState();
    productId = widget.productId;
    _vmpBlocProvider = BlocProvider.of<ProductBloc>(context);
    _vmpBlocProvider.add(ProductRequested(productId: productId));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return SizedBox(
              width: 200,
              height: 200,
              child: Scaffold(
                appBar: AppBar(title: const Text('Loading')),
                body: const LinearProgressIndicator(),
              ));
        } else if (state is ProductSuccess) {
          return ProductTile(reducedProduct: state.reducedProduct);
        } else if (state is ProductFailed) {
          return const Text("Productfailed");
        }
        return const Text("Neither Productloading or productsuccess");
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
