import 'dart:convert'; // json.decode için gerekli

import 'package:dio/dio.dart';
import '../models/government_agency.dart';

class GovernmentService {
  final Dio _dio = Dio();

  Future<void> fetchGovernmentAgencies() async {
    try {
      final response = await _dio.get('https://gist.githubusercontent.com/berkanaslan/35511991222bfc0914cd4c2c031057e2/raw/9ed856f43fc499be9f88c3b01608bce9b667eff6/kurumlar.json');

      if (response.statusCode == 200) {
        // JSON verisini doğru şekilde işlemek için kontrol
        dynamic responseData = response.data;
        if (responseData is String) {
          // String olan veriyi JSON olarak decode et
          List<dynamic> jsonData = json.decode(responseData);
          List<GovernmentAgency> agencies = jsonData.map((item) => GovernmentAgency.fromJson(item)).toList();

          // Konsola çıktıları yazdır
          agencies.forEach((agency) {
            print('Agency: ${agency.title}');
            print('Code: ${agency.code}');
            print('Link: ${agency.link}');
            print('Tel: ${agency.tel}');
            print('Email: ${agency.email}');
            print('Address: ${agency.address}');
            print('----------------------');
          });
        } else {
          print('Response data is not a String');
        }
      } else {
        print('Failed to load agencies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

void main() {
  var service = GovernmentService();
  service.fetchGovernmentAgencies();
}

