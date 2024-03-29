import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourney_craft/app/shared/models/tourney.dart';

import '../../modules/complete_tourney/models/aux_matches_model.dart';

class FirestoreService {
  //get data from firestore
  final CollectionReference _tourneyCollection =
      FirebaseFirestore.instance.collection('tourneys');

  bool hasError = true;

  //CREATE TOURNEY
  Future<({String message, String tourneyId})> createTourney({
    required String tourneyName,
    required int playersNumber,
    required int adminPassword,
  }) async {
    try {
      DocumentReference documentReference = await _tourneyCollection.add(
        {
          'tourneyName': tourneyName,
          'groups': {},
          'groupsQuantity': 0,
          'playersNumber': playersNumber,
          'status': 0,
          'adminPassword': adminPassword,
          'matches': [],
          'dateTime': DateTime.now(),
        },
      ).whenComplete(() {
        hasError = false;
      });

      if (hasError) {
        return (
          message: 'Erro ao criar torneio!',
          tourneyId: documentReference.id,
        );
      } else {
        return (
          message: 'Torneio criado com sucesso!',
          tourneyId: documentReference.id,
        );
      }
    } catch (e) {
      print('ERRO: ${e.toString()}');
      return (
        message: 'ERRO: ${e.toString()}',
        tourneyId: '...',
      );
    }
  }

  Future<void> createEndPhase({required String tourneyId}) async {
    await _tourneyCollection.doc(tourneyId).collection('endPhase').add(
      {
        'quarters': [],
        'semis': [],
        'thirdPlace': {},
        'finalMatch': {},
        'losers': {},
      },
    );
  }

  //READ TOURNEY
  Future<Map<String, dynamic>> getTourneyById({
    required String tourneyId,
  }) async {
    try {
      // Obtendo a referência do documento
      final doc = await _tourneyCollection.doc(tourneyId).get();

      if (doc.exists) {
        // Convertendo o documento para um mapa
        final data = doc.data() as Map<String, dynamic>;

        // Retornando o mapa
        return data;
      } else {
        // Documento não encontrado
        return {'error': 'Torneio não encontrado!'};
      }
    } catch (e) {
      print(e);
      return {'error': e.toString()};
    }
  }

  Future<List<PlayerModel>> getPlayersList({required String tourneyId}) async {
    try {
      final playersList = await _tourneyCollection
          .doc(tourneyId)
          .collection('playersList')
          .get();

      return playersList.docs
          .map((player) => PlayerModel.fromMap(player.id, player.data()))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  //UPDATE TOURNEY
  Future<String> putPlayerInTourney({
    required String playerName,
    required String teamName,
    required String tourneyId,
  }) async {
    try {
      final doc = await _tourneyCollection.doc(tourneyId).get();

      if (!doc.exists) {
        return 'Torneio não encontrado!';
      }

      await _tourneyCollection.doc(tourneyId).collection('playersList').add({
        'playerName': playerName,
        'teamName': teamName,
        'points': 0,
        'wins': 0,
        'loses': 0,
        'ties': 0,
        'goalsMade': 0,
        'goalsSuffered': 0,
      }).whenComplete(() {
        hasError = false;
      });

      if (hasError) {
        return 'Erro ao cadatrar Jogador!';
      } else {
        return 'Jogador cadastrado com Sucesso!';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> updateTourneyStatus({
    required String tourneyId,
    required int status,
  }) async {
    await _tourneyCollection.doc(tourneyId).update({
      'status': status,
    });
  }

  Future<String> updateTourneyGroups({
    required String tourneyId,
    required List<List<String>> groups,
    required List<AuxMatchesModel> matches,
  }) async {
    try {
      Map<String, dynamic> groupsToInsert = {};

      for (int i = 0; i < groups.length; i++) {
        final oneWayMapMatches = converterParaMapa(matches[i].oneWayMatches);
        final returnMapMatches = converterParaMapa(matches[i].returnMatches);

        groupsToInsert['group${i + 1}'] = {
          'oneWayMatches': oneWayMapMatches,
          'returnMatches': returnMapMatches,
          'players': groups[i],
        };
      }

      await _tourneyCollection
          .doc(tourneyId)
          .update({'groups': groupsToInsert}).whenComplete(() {
        hasError = false;
      });

      if (hasError) {
        return 'Erro ao atualizar Grupos!';
      } else {
        return 'Grupos atualizados com Sucesso!';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> updateGroupsQuantity({
    required String tourneyId,
    required int groupsQuantity,
  }) async {
    await _tourneyCollection.doc(tourneyId).update({
      'groupsQuantity': groupsQuantity,
      'groups': {},
    });
  }

  //DELETE TOURNEY

  //AUXILIARY METHODS
  Future<bool> doesIdExist({required String documentId}) async {
    try {
      final docSnapshot = await _tourneyCollection.doc(documentId).get();
      return docSnapshot.exists;
    } catch (e) {
      print('Erro ao verificar a existência do ID: $e');
      return false;
    }
  }

  Future<int> contarDocumentos(String docId, String collectionName) async {
    try {
      QuerySnapshot querySnapshot =
          await _tourneyCollection.doc(docId).collection(collectionName).get();

      // Retorna a quantidade de documentos na coleção
      return querySnapshot.size;
    } catch (e) {
      print('Erro ao contar documentos: $e');
      return -1; // Retorna -1 em caso de erro
    }
  }

  Map<String, List<Map<String, dynamic>>> converterParaMapa(
      List<List<Map<String, dynamic>>> listaDeRodadas) {
    Map<String, List<Map<String, dynamic>>> mapaDeConfrontos = {};

    for (int i = 0; i < listaDeRodadas.length; i++) {
      String chaveRodada = 'rodada${i + 1}';
      List<Map<String, dynamic>> confrontos = listaDeRodadas[i];

      mapaDeConfrontos[chaveRodada] = confrontos;
    }

    return mapaDeConfrontos;
  }
}
