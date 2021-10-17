import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/models/reduced_product.dart' as rp;
import 'dart:core';

class ProductTile extends StatefulWidget {
  final rp.ReducedProduct reducedProduct;
  const ProductTile({required rp.ReducedProduct reducedProduct, Key? key})
      // ignore: prefer_initializing_formals
      : reducedProduct = reducedProduct,
        super(key: key);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width - 10,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(widget.reducedProduct.image.url,
                            fit: BoxFit.fitHeight)),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ExpansionTile(
                          title: Text(
                            widget.reducedProduct.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  textCategoryString("Alkoholtype: ",
                                      widget.reducedProduct.category, context),
                                  textCategoryString(
                                      "Produksjonsland: ",
                                      widget.reducedProduct.mainCountry,
                                      context),
                                  textCategoryString(
                                      "Volum: ",
                                      (((widget.reducedProduct.volume * 100)
                                              .toInt()
                                              .toString()) +
                                          "cl"),
                                      context),
                                  textCategoryString(
                                      "Alkoholprosent: ",
                                      widget.reducedProduct.alcohol.toString() +
                                          "%",
                                      context),
                                  textCategoryString(
                                      "Literspris: ",
                                      widget.reducedProduct.litrePrice
                                              .toString() +
                                          "kr",
                                      context),
                                  textCategoryString(
                                      "Pris per flaske: ",
                                      widget.reducedProduct.price.toString() +
                                          "kr",
                                      context),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            textInfoString(
                                "Pris per shot",
                                (calculatePricePerShotWithSpoilage(
                                            widget.reducedProduct.price,
                                            widget.reducedProduct.volume)
                                        .toStringAsFixed(2) +
                                    "kr"),
                                context),
                            textInfoString(
                                "Pris per shot avrundet",
                                (calculateFinalShotPriceCeiling(
                                            widget.reducedProduct.price,
                                            widget.reducedProduct.volume)
                                        .toStringAsFixed(2) +
                                    "kr"),
                                context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget textInfoString(String text, String value, context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: Theme.of(context).textTheme.subtitle1),
      ),
      Align(
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(value, style: Theme.of(context).textTheme.subtitle2),
            )),
      ),
    ],
  );
}

Widget textCategoryString(String category, String value, context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Text(category, style: Theme.of(context).textTheme.subtitle1),
        Text(value, style: Theme.of(context).textTheme.subtitle2)
      ],
    ),
  );
}

double calculateAmountShots(double volume) {
  return volume * 100 / 4;
}

double calculatePricePerShot(double price, double amountShots) {
  return price / amountShots;
}

double calculatePricePerShotWithSpoilage(double price, double volume) {
  return calculatePricePerShot(price, calculateAmountShots(volume)) * 1.4;
}

double calculateFinalShotPriceCeiling(double price, double volume) {
  return (calculatePricePerShotWithSpoilage(price, volume) / 5).ceilToDouble() *
      5;
}


// name: name,
//       price: price,
//       image: image,
//       volume: volume,
//       alcohol: alcohol,
//       category: category,
//       mainCountry: country,
//       litrePrice: litrePrice,
