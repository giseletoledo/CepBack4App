import 'package:cepapp/page/cep_busca_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//åimport 'page/cep_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    const MaterialApp(home: CepBuscaApi()),
  );
}
