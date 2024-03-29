// ignore_for_file: public_member_api_docs, sort_constructors_first

class TourneyModel {
  String tourneyName;
  List<PlayerModel> players;
  Map<String, GroupModel> groups;
  int playersNumber;
  int groupsQuantity;
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
    required this.groupsQuantity,
    required this.status,
    required this.adminPassword,
    required this.matches,
    // required this.endPhase,
    required this.timestamp,
  });

  factory TourneyModel.fromFirestore(Map<String, dynamic> data) {
    Map<String, GroupModel> groupsList = {};

    (data['groups'] as Map<String, dynamic>?)?.forEach((key, value) {
      List<String> playerIds = List<String>.from(value['players']);

      List<MatchModel> matches =
          (value['matches'] as List<dynamic>?)?.map((matchData) {
                // Converta os dados da partida para instâncias de MatchModel conforme necessário
                return MatchModel(
                  player1Id: matchData['player1Id'] ?? '',
                  player2Id: matchData['player2Id'] ?? '',
                  player1Goals: matchData['player1Goals'] ?? 0,
                  player2Goals: matchData['player2Goals'] ?? 0,
                );
              }).toList() ??
              [];

      groupsList[key] = GroupModel(
        playersIds: playerIds,
        matches: matches,
      );
    });

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
      players: [],
      groups: groupsList,
      playersNumber: data['playersNumber'] ?? 0,
      groupsQuantity: data['groupsQuantity'] ?? 0,
      status: data['status'] ?? 0,
      adminPassword: data['adminPassword'] ?? '',
      matches: matchesList,
      // endPhase: endPhase,
      timestamp: DateTime.parse(data['dateTime'].toDate().toString()),
    );
  }

  TourneyModel copyWith({
    String? tourneyName,
    List<PlayerModel>? players,
    Map<String, GroupModel>? groups,
    int? playersNumber,
    int? groupsQuantity,
    int? status,
    int? adminPassword,
    List<MatchModel>? matches,
    DateTime? timestamp,
  }) {
    return TourneyModel(
      tourneyName: tourneyName ?? this.tourneyName,
      players: players ?? this.players,
      groups: groups ?? this.groups,
      playersNumber: playersNumber ?? this.playersNumber,
      groupsQuantity: groupsQuantity ?? this.groupsQuantity,
      status: status ?? this.status,
      adminPassword: adminPassword ?? this.adminPassword,
      matches: matches ?? this.matches,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class PlayerModel {
  String id;
  String playerName;
  String teamName;
  int points;
  int wins;
  int loses;
  int ties;
  int goalsMade;
  int goalsSuffered;

  PlayerModel({
    required this.id,
    required this.playerName,
    required this.teamName,
    required this.points,
    required this.wins,
    required this.loses,
    required this.ties,
    required this.goalsMade,
    required this.goalsSuffered,
  });

  static PlayerModel get sample => PlayerModel(
        playerName: 'Aux',
        id: 'NULL',
        teamName: 'Aux de Partidas',
        points: 0,
        wins: 0,
        loses: 0,
        ties: 0,
        goalsMade: 0,
        goalsSuffered: 0,
      );

  // Método factory para converter dados de um mapa para uma instância de PlayerModel
  factory PlayerModel.fromMap(String id, Map<String, dynamic> data) {
    return PlayerModel(
      id: id,
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

  @override
  String toString() {
    return '\nPlayerModel(\n playerName: $playerName,\n teamName: $teamName,\n points: $points,\n wins: $wins,\n loses: $loses,\n ties: $ties,\n goalsMade: $goalsMade,\n goalsSuffered: $goalsSuffered\n)';
  }
}

class MatchModel {
  String player1Id;
  String player2Id;
  int player1Goals;
  int player2Goals;

  MatchModel({
    required this.player1Id,
    required this.player2Id,
    required this.player1Goals,
    required this.player2Goals,
  });

  // Método factory para converter dados de um mapa para uma instância de MatchModel
  factory MatchModel.fromMap(Map<String, dynamic> data) {
    return MatchModel(
      player1Id: data['player1Id'] ?? '',
      player2Id: data['player2Id'] ?? '',
      player1Goals: data['player1Goals'] ?? 0,
      player2Goals: data['player2Goals'] ?? 0,
    );
  }

  @override
  String toString() {
    return '\nMatchModel(\n player1Id: $player1Id,\n player2Id: $player2Id,\n player1Goals: $player1Goals,\n player2Goals: $player2Goals\n)';
  }
}

class GroupModel {
  List<String> playersIds;
  List<MatchModel> matches;

  GroupModel({
    required this.playersIds,
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
