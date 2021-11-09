import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({required this.text, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0.0, vertical: -3.0),
      contentPadding: const EdgeInsets.only(left: 30, bottom: 0),
      horizontalTitleGap: 0,
      leading: Container(
        height: 10.0,
        width: 10.0,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(text, style: Theme.of(context).textTheme.bodyText2),
    );
  }
}
