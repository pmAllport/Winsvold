import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/vinmonopolet/product_bucket.dart';
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
            productBloc.add(ProductRequested(productId: int.parse(input)));
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
