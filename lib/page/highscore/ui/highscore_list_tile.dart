import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HighscoreListTile extends StatelessWidget {
  final int rank;
  final String name;
  final int score;

  const HighscoreListTile({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('#$rank'),
      title: Text(name),
      trailing: Text('points').tr(namedArgs: {'score': '$score'}),
    );
  }
}
