import 'package:cepapp/repositories/cep_api_repository.dart';
import 'package:flutter/material.dart';

import '../model/cep_model.dart';

class CepBuscaApi extends StatefulWidget {
  const CepBuscaApi({super.key});

  @override
  State<CepBuscaApi> createState() => _CepBuscaApiState();
}

class _CepBuscaApiState extends State<CepBuscaApi> {
  var cepController = TextEditingController(text: "");

  bool loading = false;

  CepModel viacepModel = CepModel(
    // Initialize with an empty CepModel
    cep: '',
    logradouro: '',
    complemento: '',
    bairro: '',
    localidade: '',
    uf: '',
    ibge: '',
    gia: '',
    ddd: '',
    siafi: '',
  );

  var viaCEPRepository = CepApiRepository();

  void showCepNotFoundAlert() {
    showDialog(
      context: context, // Use the context of the current page.
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('CEP Not Found'),
          content: const Text('The provided CEP was not found.'),
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
                    });
                    final foundCepData =
                        await viaCEPRepository.fetchCepApi(cep);
                    print(foundCepData);
                    if (foundCepData.cep.isNotEmpty &&
                        foundCepData.logradouro.isNotEmpty &&
                        foundCepData.complemento.isNotEmpty &&
                        foundCepData.bairro.isNotEmpty &&
                        foundCepData.localidade.isNotEmpty &&
                        foundCepData.uf.isNotEmpty &&
                        foundCepData.ibge.isNotEmpty &&
                        foundCepData.gia.isNotEmpty &&
                        foundCepData.ddd.isNotEmpty &&
                        foundCepData.siafi.isNotEmpty) {
                      Column(
                        children: [
                          Text(
                            "CEP: ${viacepModel.cep}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Logradouro: ${viacepModel.logradouro}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Complemento: ${viacepModel.complemento}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Bairro: ${viacepModel.bairro}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Localidade: ${viacepModel.localidade}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "UF: ${viacepModel.uf}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    } else {
                      // Todos os campos estão vazios ou nulos
                      print("Todos os campos estão vazios ou nulos");
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
