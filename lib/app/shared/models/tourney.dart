// ignore_for_file: public_member_api_docs, sort_constructors_first

class TourneyModel {
  String tourneyName;
  List<PlayerModel> players;
  List<GroupModel> groups;
  int playersNumber;
  int status;
  int adminPassword;
  List<MatchModel> matches;
  // EndPhaseModel endPhase;
  DateTime timestamp;

  TourneyModel({
    required this.tourneyName,
    required this.players,
    required this.groups,
    required this.playersNumber,
    required this.status,
    required this.adminPassword,
    required this.matches,
    // required this.endPhase,
    required this.timestamp,
  });

  factory TourneyModel.fromFirestore(Map<String, dynamic> data) {
    List<PlayerModel> playersList = (data['players'] as List<dynamic>?)
            ?.map((player) => PlayerModel.fromMap(player))
            .toList() ??
        [];

    List<GroupModel> groupsList = (data['groups'] as List<dynamic>?)
            ?.map((group) => GroupModel(
                  players: List<PlayerModel>.from(group['players']
                      .map((player) => PlayerModel.fromMap(player))),
                  matches: List<MatchModel>.from(group['matches']
                      .map((match) => MatchModel.fromMap(match))),
                ))
            .toList() ??
        [];

    List<MatchModel> matchesList = (data['matches'] as List<dynamic>?)
            ?.map((match) => MatchModel.fromMap(match))
            .toList() ??
        [];

    // EndPhaseModel endPhase = EndPhaseModel(
    //   quarters: (data['endPhase']?['quarters'] as List<dynamic>?)
    //           ?.map((match) => MatchModel.fromMap(match))
    //           .toList() ??
    //       [],
    //   semis: (data['endPhase']?['semis'] as List<dynamic>?)
    //           ?.map((match) => MatchModel.fromMap(match))
    //           .toList() ??
    //       [],
    //   thirdPlace: MatchModel.fromMap(data['endPhase']?['thirdPlace'] ?? {}),
    //   finalMatch: MatchModel.fromMap(data['endPhase']?['finalMatch'] ?? {}),
    //   losers: MatchModel.fromMap(data['endPhase']?['losers'] ?? {}),
    // );

    return TourneyModel(
      tourneyName: data['tourneyName'] ?? '',
      players: playersList,
      groups: groupsList,
      playersNumber: data['playersNumber'] ?? 0,
      status: data['status'] ?? 0,
      adminPassword: data['adminPassword'] ?? '',
      matches: matchesList,
      // endPhase: endPhase,
      timestamp: DateTime.parse(data['dateTime'].toDate().toString()),
    );
  }
}

class PlayerModel {
  String playerName;
  String teamName;
  int points;
  int wins;
  int loses;
  int ties;
  int goalsMade;
  int goalsSuffered;

  PlayerModel({
    required this.playerName,
    required this.teamName,
    required this.points,
    required this.wins,
    required this.loses,
    required this.ties,
    required this.goalsMade,
    required this.goalsSuffered,
  });

  // Método factory para converter dados de um mapa para uma instância de PlayerModel
  factory PlayerModel.fromMap(Map<String, dynamic> data) {
    return PlayerModel(
      playerName: data['playerName'] ?? '',
      teamName: data['teamName'] ?? '',
      points: data['points'] ?? 0,
      wins: data['wins'] ?? 0,
      loses: data['loses'] ?? 0,
      ties: data['ties'] ?? 0,
      goalsMade: data['goalsMade'] ?? 0,
      goalsSuffered: data['goalsSuffered'] ?? 0,
    );
  }
}

class MatchModel {
  PlayerModel player1;
  PlayerModel player2;
  int player1Goals;
  int player2Goals;

  MatchModel({
    required this.player1,
    required this.player2,
    required this.player1Goals,
    required this.player2Goals,
  });

  // Método factory para converter dados de um mapa para uma instância de MatchModel
  factory MatchModel.fromMap(Map<String, dynamic> data) {
    return MatchModel(
      player1: PlayerModel.fromMap(data['player1']),
      player2: PlayerModel.fromMap(data['player2']),
      player1Goals: data['player1Goals'] ?? 0,
      player2Goals: data['player2Goals'] ?? 0,
    );
  }
}

class GroupModel {
  List<PlayerModel> players;
  List<MatchModel> matches;

  GroupModel({
    required this.players,
    required this.matches,
  });
}

class EndPhaseModel {
  List<MatchModel> quarters;
  List<MatchModel> semis;
  MatchModel thirdPlace;
  MatchModel finalMatch;
  MatchModel losers;

  EndPhaseModel({
    required this.quarters,
    required this.semis,
    required this.thirdPlace,
    required this.finalMatch,
    required this.losers,
  });
}
