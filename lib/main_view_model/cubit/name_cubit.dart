import 'package:bugun_juma/main_view_model/quran_model/quran.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io'; // Import 'dart:io' for SecurityContext
import 'package:http/http.dart' as http;

class NameCubit extends Cubit<String>{
  NameCubit():super("");
  late Future<Quran> futureQuran;
  void update() {

    futureQuran = fetchData();
  }
  void filterQuran(String query) {

      // futureQuran o'zgaruvchisiga filterMovies kabi ishlovchi funksiya
      // Qidiruv amalini bajarish
      futureQuran = fetchData().then((quran) {
        // quran ichidagi malumotlarni query ga moslashtirish
        List<Data> filteredData = quran.data!
            .where((data) => data.namaLatin!.toLowerCase().contains(query.toLowerCase()))
            .toList();

        // qidiruv natijasini qaytarish
        return (Quran(data: filteredData));

      });


  }


  Future<Quran> fetchData() async {
    String url = 'https://equran.id/api/v2/surat';
    Uri myUrl = Uri.parse(url);

    // Bypass SSL certificate verification
    HttpClient httpClient = HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    final response = await httpClient.getUrl(myUrl).then((request) => request.close());

    if (response.statusCode == 200) {
      String responseBody = await response.transform(utf8.decoder).join();
      return Quran.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  void getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? "";
    String famly = prefs.getString('famly') ?? "";
    emit("$name $famly");
    print("Mana: $name $famly");
  }

  void setName(String name, String famly) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('famly', famly);
    prefs.setString('name', name);
    emit("$name $famly");

  }

  void getSelected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? itemsIndex = prefs.getStringList('itemsIndex');
    print(itemsIndex);
  }

  void setSelected(List<String> itemsIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('itemsIndex', itemsIndex);

  }


}