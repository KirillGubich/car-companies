import 'package:flutter/material.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({Key? key}) : super(key: key);

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Catalog", style: TextStyle(fontSize: 50)),
    );
  }
}
