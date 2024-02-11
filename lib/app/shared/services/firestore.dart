import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get data from firestore
  final CollectionReference _tourneyCollection =
      FirebaseFirestore.instance.collection('tourneys');

  //CREATE TOURNEY
  Future<String> createTourney({
    required String tourneyName,
    required int playersNumber,
    required int tourneyCode,
  }) async {
    bool hasError = true;
    try {
      await _tourneyCollection.add(
        {
          'tourneyName': tourneyName,
          'playersNumber': playersNumber,
          'tourneyCode': tourneyCode,
          'timestamp': FieldValue.serverTimestamp(),
        },
      ).whenComplete(() {
        hasError = false;
      });

      if (hasError) {
        return 'Erro ao criar torneio!';
      } else {
        return 'Torneio criado com sucesso!';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
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

  //UPDATE TOURNEY
  Future<String> putPlayerInTourney({
    required String playerName,
    required String teamName,
    required String tourneyId,
  }) async {
    bool hasError = true;
    try {
      await _tourneyCollection.doc(tourneyId).update({
        'players': FieldValue.arrayUnion([
          {
            'playerName': playerName,
            'teamName': teamName,
          }
        ])
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
}
