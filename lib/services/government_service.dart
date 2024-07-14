import 'dart:convert'; // json.decode için gerekli
import 'package:dio/dio.dart';
import '../models/government_agency.dart';

class GovernmentService {
  final Dio _dio = Dio();

  Future<List<GovernmentAgency>> fetchGovernmentAgencies() async {
    try {
      final response = await _dio.get(
          'https://gist.githubusercontent.com/berkanaslan/35511991222bfc0914cd4c2c031057e2/raw/9ed856f43fc499be9f88c3b01608bce9b667eff6/kurumlar.json');

      if (response.statusCode == 200) {
        dynamic responseData = response.data;
        if (responseData is String) {
          List<dynamic> jsonData = json.decode(responseData);
          return jsonData
              .map((item) => GovernmentAgency.fromJson(item))
              .toList();
        } else {
          throw Exception('Response data is not a String');
        }
      } else {
        throw Exception('Failed to load agencies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}



