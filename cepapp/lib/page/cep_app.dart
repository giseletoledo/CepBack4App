import 'package:cepapp/repositories/cep_back4app_repository.dart';
import 'package:cepapp/model/cep_back4app_model.dart';
import 'package:flutter/material.dart';

class CepApp extends StatefulWidget {
  const CepApp({super.key});

  @override
  State<CepApp> createState() => _CepAppState();
}

class _CepAppState extends State<CepApp> {
  var cepController = TextEditingController(text: "");

  bool loading = false;

  CepBack4AppModel viacepModel = CepBack4AppModel();

  var viaCEPRepository = CepBack4AppRepository();

  void showCepNotFoundAlert() {
    showDialog(
      context: context, // Use the context of the current page.
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('CEP não encontrado'),
          content: const Text('Favor digitar outro número válido'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text(
                "Consulta de CEP",
                style: TextStyle(fontSize: 22),
              ),
              TextField(
                controller: cepController,
                keyboardType: TextInputType.number,
                onChanged: (String value) async {
                  var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                  if (cep.length == 8) {
                    setState(() {
                      loading = true;
                      viacepModel = CepBack4AppModel(); // Reset the model
                    });
                    final foundCepData =
                        await viaCEPRepository.fetchCepDataBack4App(cep);
                    print(foundCepData);

                    if (foundCepData.isNotEmpty) {
                      // CEP found
                      setState(() {
                        viacepModel = foundCepData[0];
                      });
                    } else if (foundCepData[0].results!.isEmpty) {
                      // CEP not found
                      showCepNotFoundAlert();
                    }

                    setState(() {
                      loading = false;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              if (viacepModel.results != null)
                for (var result in viacepModel.results!)
                  if (result.cep != null &&
                      result.localidade != null &&
                      result.uf != null)
                    Text(
                      "${result.cep} - ${result.localidade} - ${result.uf}",
                      style: const TextStyle(fontSize: 22),
                    ),
              if (loading) const CircularProgressIndicator(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {},
        ),
      ),
    );
  }
}
