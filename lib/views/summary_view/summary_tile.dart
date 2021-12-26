import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 4,
            fit: FlexFit.loose,
            child: Text(
              widget.reducedProduct.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  reducedProduct.amount != null
                      ? Text(
                          reducedProduct.amount.toString() + "stk",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      : Text(
                          "Ikke satt",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                  reducedProduct.amount != null
                      ? Text(
                          (reducedProduct.amount! * reducedProduct.price)
                                  .toStringAsFixed(2) +
                              "kr",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1)
                      : Text("0.00kr",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
