import 'package:cepapp/model/cep_model.dart';
import 'package:flutter/material.dart';

class AddressDetails extends StatelessWidget {
  final CepModel foundCepData;

  AddressDetails(this.foundCepData);

  @override
  Widget build(BuildContext context) {
    if (foundCepData == null) {
      return Container(); // Ou outro widget vazio, se preferir
    }

    return Column(
      children: [
        if (foundCepData.cep.isNotEmpty)
          Text(
            "CEP: ${foundCepData.cep}",
            style: const TextStyle(fontSize: 18),
          ),
        if (foundCepData.logradouro.isNotEmpty)
          Text(
            "Logradouro: ${foundCepData.logradouro}",
            style: const TextStyle(fontSize: 18),
          ),
        if (foundCepData.complemento.isNotEmpty)
          Text(
            "Complemento: ${foundCepData.complemento}",
            style: const TextStyle(fontSize: 18),
          ),
        if (foundCepData.bairro.isNotEmpty)
          Text(
            "Bairro: ${foundCepData.bairro}",
            style: const TextStyle(fontSize: 18),
          ),
        if (foundCepData.localidade.isNotEmpty)
          Text(
            "Localidade: ${foundCepData.localidade}",
            style: const TextStyle(fontSize: 18),
          ),
        if (foundCepData.uf.isNotEmpty)
          Text(
            "UF: ${foundCepData.uf}",
            style: const TextStyle(fontSize: 18),
          ),
      ],
    );
  }
}
