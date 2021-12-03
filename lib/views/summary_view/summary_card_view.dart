import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/product_view/product_bucket.dart';
import 'package:winsvold/models/reduced_product.dart';
import 'package:winsvold/views/ProductView/product_invalid.dart';
import 'package:winsvold/views/ProductView/product_view_tile.dart';
import 'package:winsvold/views/summary_view/summary_tile.dart';

class SummaryCard extends StatefulWidget {
  final ReducedProduct reducedProduct;
  const SummaryCard({
    required this.reducedProduct,
    Key? key,
  }) : super(key: key);

  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard>
    with AutomaticKeepAliveClientMixin {
  late ReducedProduct reducedProduct;

  @override
  void initState() {
    super.initState();
    reducedProduct = widget.reducedProduct;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SummaryListTile(
                    reducedProduct: reducedProduct,
                    context: context,
                  )),
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
