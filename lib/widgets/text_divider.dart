import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;

  const TextDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Row(children: <Widget>[
          const Expanded(
              child: Divider(
            color: Color(0xff9DB7CB),
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(text),
          ),
          const Expanded(child: Divider(color: Color(0xff9DB7CB))),
        ]));
  }
}
