import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get data from firestore
  final CollectionReference _tourneyCollection =
      FirebaseFirestore.instance.collection('tourneys');

  //CREATE TOURNEY
  Future<String> createTourney({
    required String tourneyName,
    required int playersNumber,
  }) async {
    bool hasError = true;
    try {
      await _tourneyCollection.add(
        {
          'tourneyName': tourneyName,
          'playersNumber': playersNumber,
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

  //UPDATE TOURNEY

  //READ TOURNEY

  //DELETE TOURNEY
}
