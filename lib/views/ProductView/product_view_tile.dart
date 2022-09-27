import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/product_view/product_bucket.dart';
import 'package:winsvold/models/reduced_product.dart' as rp;
import 'dart:core';

class ProductViewTile extends StatefulWidget {
  final BuildContext context;
  final rp.ReducedProduct reducedProduct;
  const ProductViewTile(
      {required this.context, required this.reducedProduct, Key? key})
      : super(key: key);

  @override
  _ProductViewTileState createState() => _ProductViewTileState();
}

class _ProductViewTileState extends State<ProductViewTile> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width - 80,
              child: Stack(
                children: [
                  Center(
                    child: Image.network(widget.reducedProduct.image.url,
                        fit: BoxFit.fitHeight),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => {_buildDialog(context)},
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.primary,
                          size: 30.0,
                        ),
                      )),
                ],
              )),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: _isExpanded ? 220 : 65,
            width: MediaQuery.of(context).size.width - 80,
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: ListTileTheme(
                    contentPadding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ExpansionTile(
                          backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          onExpansionChanged: (bool expanded) {
                            setState(() => _isExpanded = expanded);
                          },
                          trailing: Icon(
                              _isExpanded
                                  ? Icons.arrow_drop_down_circle
                                  : Icons.arrow_drop_down_circle_outlined,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary),
                          title: Padding(
                            padding: EdgeInsets.only(
                                left: (MediaQuery.of(context).size.width / 8)),
                            child: Text(
                              widget.reducedProduct.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: Column(
                                children: [
                                  textCategoryString(
                                      "Alkoholtype: ",
                                      widget.reducedProduct.subCategory,
                                      context),
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
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: widget.reducedProduct.usesShots
                ? Column(
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
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: textInfoString(
                            "Pris per flaske",
                            calculateBottlePrice(widget.reducedProduct.price)
                                    .toStringAsFixed(2) +
                                "kr",
                            context),
                      )
                    ],
                  ),
          ),
        ],
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

double calculateBottlePrice(double price) {
  return (price / 5).ceilToDouble() * 5;
}

// This is a bad piece of code, this can definitely be rewritten.
// The code refers to two different sets of listbody and actionbodies.
// Listbody determines the text and header values which describe the type of alert.
// Actionbody contains the buttons and their actions.
// initialListBody and initialActionBody contain a description of the problem, and an action for the user to determine whether or not
// an incorrect productnumber was read.
// submitListBody and submitActionBody contain an inputfield for the user to enter the correct product id.
// listBody and actionBody is a pointer to these two widgets, which changes depending upon if the user has pressed "Yes"
// in the initial alert. Upon pressing "yes", the alert changes to the inputfield, defined in submitListBody and submitActionBody.
// This is superjank and should be refactored, but works for now. #TemporarilyPermanent.
Future<void> _buildDialog(BuildContext tileContext) async {
  return showDialog<void>(
    context: tileContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      List<Widget> submitListBody = [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text('Vennligst skriv inn det korrekte produktnummeret.'),
        ),
        TextField(
          onSubmitted: (String input) {
            ProductBloc productBloc = BlocProvider.of<ProductBloc>(tileContext);
            productBloc
                .add(ProductRequested(productId: int.parse(input), amount: 0));
            Navigator.of(context).pop();
          },
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF002025))),
            hintText: 'Skriv inn produktnummer',
          ),
        ),
      ];
      List<Widget> submitActionBody = [];

      List<Widget> intialActionBody = [];
      List<Widget> intialListBody = [];

      List<Widget> listBody;
      List<Widget> actionBody;

      bool hasEnteredSubmit = false;

      // For null-safety reasons, we point to an empty widgetlist, even though it will never not be pointing to the correct widget list (hopefully).
      listBody = intialListBody;
      actionBody = intialActionBody;
      return StatefulBuilder(builder: (context, setState) {
        if (!hasEnteredSubmit) {
          List<Widget> intialListBody = [
            const Text('Oops, har applikasjonen lest feil produktkode?'),
          ];
          List<Widget> intialActionBody = [
            TextButton(
              child: const Text('Ja'),
              onPressed: () => setState(() =>
                  {listBody = submitListBody, actionBody = submitActionBody}),
            ),
            TextButton(
              child: const Text('Nei'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ];
          listBody = intialListBody;
          actionBody = intialActionBody;
          hasEnteredSubmit = true;
        }

        return AlertDialog(
            title: const Text('Feil produkt?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: listBody,
              ),
            ),
            actions: actionBody);
      });
    },
  );
}

// name: name,
//       price: price,
//       image: image,
//       volume: volume,
//       alcohol: alcohol,
//       category: category,
//       mainCountry: country,
//       litrePrice: litrePrice,
