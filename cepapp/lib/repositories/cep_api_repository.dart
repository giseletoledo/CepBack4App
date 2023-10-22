import 'package:dio/dio.dart';
import '../model/cep_model.dart';

class CepApiRepository {
  Future<CepModel> fetchCepApi(String cep) async {
    Dio dio = Dio();

    // Define the API URL
    String url = 'https://viacep.com.br/ws/$cep/json/';

    // Make the API call
    Response response = await dio.get(url);

    // Check if the response was successful
    if (response.statusCode == 200) {
      // Decode the JSON response
      Map<String, dynamic> data = response.data;

      // Create a CepModel object from the response data
      CepModel cepModel = CepModel.fromMap(data);

      // Return the CepModel object
      return cepModel;
    } else {
      // Throw an error for unsuccessful response
      throw Exception(
          'API call failed with status code ${response.statusCode}');
    }
  }
}
