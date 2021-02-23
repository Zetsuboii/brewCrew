import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_brewcrewnew/models/brew.dart';
import 'package:flutter_brewcrewnew/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? <Brew>[];
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        // For every index return a widget
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
