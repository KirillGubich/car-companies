import 'package:firebase_database/firebase_database.dart';

import '../api/weather_api_client.dart';
import '../model/company.dart';

class CompanyDao {
  static final databaseRef = FirebaseDatabase.instance.ref();
  static List<Company> companies = <Company>[];
  static List<Company> storageData = <Company>[];

  static List<Company> readAll() {
    List<Company> list = <Company>[];
    list.addAll(companies);
    return list;
  }

  static Future<List<Company>> uploadData() async {
    if (companies.isNotEmpty) {
      return companies;
    }
    await readFromFirebase();
    for (Company company in storageData) {
      WeatherApiClient.getCurrentTemperature(company.location).then((value) {
        company.weather = value;
      });
    }
    companies.clear();
    companies.addAll(storageData);
    return companies;
  }

  static readFromFirebase() async {
    databaseRef.once().then((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        Map<String, dynamic> data = Map<String, dynamic>.from(
            dataSnapshot.value as Map<dynamic, dynamic>);
        var list = data['companies'];
        storageData.clear();
        for (var element in list) {
          var company = Company.parse(element);
          storageData.add(company);
        }
      }
    });
    return storageData;
  }
}
