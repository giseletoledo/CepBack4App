import 'package:cepapp/repositories/cep_api_repository.dart';
import 'package:flutter/material.dart';

import '../model/cep_model.dart';
import '../widgets/adress_details.dart';

class CepBuscaApi extends StatefulWidget {
  const CepBuscaApi({super.key});

  @override
  State<CepBuscaApi> createState() => _CepBuscaApiState();
}

class _CepBuscaApiState extends State<CepBuscaApi> {
  var cepController = TextEditingController(text: "");
  bool displayAddress = false;
  CepModel? foundCepData;

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
    return Scaffold(
      body: Column(
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

                foundCepData = await viaCEPRepository.fetchCepApi(cep);
                setState(() {
                  loading = false;
                });

                if (foundCepData != null) {
                  setState(() {
                    displayAddress = true;
                  });
                } else {
                  showCepNotFoundAlert();
                }
              }
            },
          ),
          const SizedBox(
            height: 50,
          ),
          if (loading) const CircularProgressIndicator(),
          if (displayAddress && foundCepData != null)
            AddressDetails(foundCepData!),
        ],
      ),
    );
  }
}
