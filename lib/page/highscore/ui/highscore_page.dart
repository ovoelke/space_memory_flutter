import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_memory_flutter/page/highscore/bloc/highscore_bloc.dart';
import 'package:space_memory_flutter/page/highscore/bloc/highscore_event.dart';
import 'package:space_memory_flutter/page/highscore/bloc/highscore_state.dart';
import 'package:space_memory_flutter/page/highscore/ui/highscore_list_tile.dart';

class HighscorePage extends StatelessWidget {
  const HighscorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HighscoreBloc()..add(RefreshHighscore()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(tr('highscores')),
        ),
        body: BlocBuilder<HighscoreBloc, HighscoreState>(
          builder: (context, state) {
            if (state.listData == null || state.listData!.isEmpty) {
              if (state.isBusy) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text(tr('no_highscores_available')));
              }
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  final bloc = context.read<HighscoreBloc>();
                  context.read<HighscoreBloc>().add(RefreshHighscore());
                  await bloc.stream.firstWhere(
                    (state) => state.isBusy == false,
                  );
                },
                child: ListView.builder(
                  itemCount: state.listData!.length,
                  itemBuilder: (context, index) {
                    final item = state.listData![index];
                    return HighscoreListTile(
                      rank: item.rank,
                      name: item.name,
                      score: item.score,
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
