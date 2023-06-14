import 'package:cats_app/models/cats_model.dart';
import 'package:cats_app/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CatsService extends ChangeNotifier {
  Future<List<CatsModel>> getCats() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Api-Key': xApiKey,
    };

// Realizar la solicitud HTTP con los encabezados
    http.Response response =
        await http.get(Uri.parse(hostApi), headers: headers);

// Verificar el código de estado de la respuesta

    // La solicitud fue exitosa

    return catsModelFromMap(
        response.body); //CatsModel.fromMap(json.decode(response.body));
  }
}
