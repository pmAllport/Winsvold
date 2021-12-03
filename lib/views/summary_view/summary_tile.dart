import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/product_view/product_bucket.dart';
import 'package:winsvold/models/reduced_product.dart' as rp;
import 'dart:core';

class SummaryListTile extends StatefulWidget {
  final BuildContext context;
  final rp.ReducedProduct reducedProduct;
  const SummaryListTile(
      {required this.context, required this.reducedProduct, Key? key})
      : super(key: key);

  @override
  _SummaryListTileState createState() => _SummaryListTileState();
}

class _SummaryListTileState extends State<SummaryListTile> {
  bool isIncorrectValueType = false;

  late final rp.ReducedProduct reducedProduct = widget.reducedProduct;

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(
              widget.reducedProduct.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          reducedProduct.amount != null
              ? Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          reducedProduct.amount.toString() + "stk",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Text(
                          (reducedProduct.amount! * reducedProduct.price)
                                  .toStringAsFixed(2) +
                              "kr",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1)
                    ],
                  ),
                )
              : Text("Ikke tilgjengelig",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1),
        ],
      ),
    );
  }
}
