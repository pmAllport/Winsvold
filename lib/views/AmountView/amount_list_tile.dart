import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/product_view/product_bucket.dart';
import 'package:winsvold/models/reduced_product.dart' as rp;
import 'dart:core';

class AmountListTile extends StatefulWidget {
  final BuildContext context;
  final rp.ReducedProduct reducedProduct;
  const AmountListTile(
      {required this.context, required this.reducedProduct, Key? key})
      : super(key: key);

  @override
  _AmountListTileState createState() => _AmountListTileState();
}

class _AmountListTileState extends State<AmountListTile> {
  bool isIncorrectValueType = false;

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width - 80,
            child: Text(
              widget.reducedProduct.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width - 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    child: Image.network(widget.reducedProduct.image.url,
                        fit: BoxFit.fitHeight),
                  ),
                  Flexible(
                    flex: 4,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        if (int.tryParse(value) == null && value.isNotEmpty) {
                          isIncorrectValueType = true;
                        } else {
                          isIncorrectValueType = false;
                          widget.reducedProduct.amount = int.parse(value);
                        }
                        refresh();
                      },
                      decoration: InputDecoration(
                        errorText:
                            isIncorrectValueType ? "Sett inn et heltall" : null,
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: isIncorrectValueType ? 3 : 2,
                                color: isIncorrectValueType
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .primaryVariant)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: isIncorrectValueType ? 3 : 2,
                                color: isIncorrectValueType
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .primaryVariant)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: isIncorrectValueType ? 3 : 2,
                                color: isIncorrectValueType
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .primaryVariant)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.5,
                                color: isIncorrectValueType
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .primaryVariant)),
                        hintText: 'Sett inn antall',
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
