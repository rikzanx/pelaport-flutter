import 'package:flutter/cupertino.dart';

pindahPageCupertino(context, Widget route) {
  Navigator.push(context, CupertinoPageRoute(builder: (_) => route));
}

Future pindahPageCupertinoResult(context, Widget route) async {
  return await Navigator.push(
      context, CupertinoPageRoute(builder: (_) => route));
}