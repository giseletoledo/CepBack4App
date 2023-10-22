import 'package:flutter/foundation.dart';

import '../model/cep_back4app_model.dart';
import '../back4app/back4app_custom_dio.dart';

class CepBack4AppRepository {
  final Back4AppCustomDio _customDio = Back4AppCustomDio();
  final String baseUrl = "/Cep";

  Future<List<CepBack4AppModel>> fetchCepDataBack4App(String cep) async {
    try {
      String cepComMascara = "${cep.substring(0, 5)}-${cep.substring(5)}";

      final response =
          await _customDio.dio.get('$baseUrl?where={"cep":"$cepComMascara"}');
      final Map<String, dynamic> data = response.data;

      // Print the API data to the console
      if (kDebugMode) {
        print("API data:");
      }
      if (kDebugMode) {
        print(data);
      }

      final CepBack4AppModel cepBack4AppModel = CepBack4AppModel.fromJson(data);
      List<CepBack4AppModel> cepBack4AppModelList = [];
      cepBack4AppModelList.add(cepBack4AppModel);
      return cepBack4AppModelList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCepData(CepBack4AppModel cepData) async {
    try {
      await _customDio.dio.post(baseUrl, data: cepData.toJson());
      if (kDebugMode) {
        print("CEP data added:");
      }
      if (kDebugMode) {
        print(cepData.toJson());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCepData(CepBack4AppModel cepData) async {
    try {
      if (cepData.results != null && cepData.results!.isNotEmpty) {
        String? objectId = cepData.results![0].objectId;
        if (objectId != null) {
          await _customDio.dio
              .put("$baseUrl/$objectId", data: cepData.toJson());
          if (kDebugMode) {
            print("CEP data updated:");
          }
          if (kDebugMode) {
            print(cepData.toJson());
          }
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCepData(String objectId) async {
    try {
      await _customDio.dio.delete("$baseUrl/$objectId");
      if (kDebugMode) {
        print("CEP data deleted:");
      }
      if (kDebugMode) {
        print("objectId: $objectId");
      }
    } catch (e) {
      rethrow;
    }
  }
}
