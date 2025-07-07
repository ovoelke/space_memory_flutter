import 'package:space_memory_flutter/page/highscore/model/highscore_list_data.dart';

class HighscoreState {
  final List<HighscoreListData>? listData;
  final bool isBusy;

  HighscoreState({this.listData, this.isBusy = false});

  HighscoreState copyWith({List<HighscoreListData>? listData, bool? isBusy}) {
    return HighscoreState(
      listData: listData ?? this.listData,
      isBusy: isBusy ?? this.isBusy,
    );
  }
}
