import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourney_craft/app/shared/constants/constants.dart';

class TourneyRepository {
  // Método para salvar um valor
  Future<void> saveValue(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Método para obter um valor
  Future<String?> getValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Método para verificar se um valor está salvo
  Future<bool> isValueSaved(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  // Método para limpar um valor
  Future<void> clearValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> clearAllValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> printInternalData() async {
    print(
      'CODE: ${await TourneyRepository().getValue(Constants.tourneyCodeFolder)}',
    );
    print(
      'PASSWORD: ${await TourneyRepository().getValue(Constants.admPasswordFolder)}',
    );
    print(
      'STATUS: ${await TourneyRepository().getValue(Constants.tourneyStatusFolder)}',
    );
  }
}

// Exemplo de uso
void main() async {
  final folderRepository = TourneyRepository();

  // Adicione uma chave à pasta 'MinhaPasta'
  await folderRepository.saveValue(
    Constants.tourneyCodeFolder,
    'Código do Torneio',
  );

  // Obtenha os minha chave 'MinhaPasta'
  final chave = await folderRepository.getValue(
    Constants.tourneyCodeFolder,
  );

  print('minha chave: $chave');
}
