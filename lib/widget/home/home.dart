import 'package:flutter/material.dart';

import 'header.dart';
import 'list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: const [
            Header(),
            List(),
          ],
        ));
  }
}
