import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HatChopCubit extends Cubit<String> {
  HatChopCubit() : super('') {
    getHatChop();
  }

  String? surahName;
  String surahUrl="";
  final _flutterDownload = MediaDownload();
  Future<String?> _createDirectory() async {
    Directory? directory;
    final path2= Directory("storage/emulated/0/BugunJumaApp/");
    path2.create();
    final path= Directory("storage/emulated/0/BugunJumaApp/Quran");
    path.create();


    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = path;
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }
  Future<void> downloadMedia(String url,bool male,String fileName,context) async {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    final directoryPath = await _createDirectory();
    if (directoryPath != null) {
      // ignore: use_build_context_synchronously
     await _flutterDownload.downloadMedia(
        context,
        url,
        directoryPath,
       fileName,

      );

      var snackBar = SnackBar(
          backgroundColor: male == false
              ? const Color(0xFF41966F)
              : const Color(0xFFFB6CF4),
          elevation: 12,
          shape: BeveledRectangleBorder(
            side: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.only(
              topLeft:
              Radius.circular(size.height * 0.22),
              topRight:
              Radius.circular(size.height * 0.22),
            ),
          ),
          content: const Center(
              child:
              Text("Iltimos kuting!")));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);

    } else {
      print('Error creating directory.');
    }
  }

  void getHatChop() async {
    print("getHatChop boshlandi"); // Tekshiruv uchun qo'shildi
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String surahName = prefs.getString('surahName') ?? "";
    surahUrl = prefs.getString('surahUrl') ?? "";
    emit(surahName);
    print("getHatChop tugadi"); // Tekshiruv uchun qo'shildi
  }

  Future<void> downloadAudio(
      String url, AudioPlayer audioPlayer) async {
    print("ishgatushdi");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("ishgatushdi2");

      final Uint8List fileBytes = response.bodyBytes;
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      final filePath = '${appDocumentsDir.path}/audio.mp3';
      final file = File(filePath);
      await file.writeAsBytes(fileBytes);
      print("ana boldi");
      print(file);

      await audioPlayer.play(
        AssetSource(filePath),
      );
    } else {
      throw Exception('Failed to load audio file');
    }
  }

  void setHatChop(String surahUrl, String surahName) async {
    print("setHatChop boshlandi"); // Tekshiruv uchun qo'shildi
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('surahName', surahName);
    prefs.setString('surahUrl', surahUrl);
    emit(surahName);
    print("setHatChop tugadi :$surahUrl"); // Tekshiruv uchun qo'shildi
  }
}
