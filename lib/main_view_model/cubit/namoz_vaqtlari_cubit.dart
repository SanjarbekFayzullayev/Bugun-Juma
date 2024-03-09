import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NamozVaqtlariListCubit extends Cubit<List<String>> {
  List<String> names = ["Bomdod", "Quyosh", "Peshin", "Asr", "Shom", "Xufton"];
  List<String> viloyatlar = [
    'Andijon',
    'Buxoro',
    'Farg\'ona',
    'Jizzax',
    "Sirdaryo",
    'Xorazm',
    'Namangan',
    'Navoiy',
    'Qashqadaryo',
    'Qoraqalpog\'iston',
    'Samarqand',
    'Surxondaryo',
    'Toshkent',
    'Toshkent shahri'
  ];
  late SharedPreferences _prefs;

  List<int> selectedIndex = [];
  double latitude = 41.2995; // Default latitude for Toshkent
  double longitude = 69.2401; // Default longitude for Toshkent
  int countIndex = 13;

  NamozVaqtlariListCubit() : super(["", "", "", "", "", ""]);

  DateTime dateTime = DateTime.now();

  void updateDate(DateTime dateTime22) {
    dateTime = dateTime22;
    updatePrayerTimes();
    initPrefs();
    getCounterIndex();
  }

  // Method to initialize shared preferences
  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    // Retrieve saved values if available
    latitude = _prefs.getDouble('latitude') ?? 41.2995;
    longitude = _prefs.getDouble('longitude') ?? 69.2401;
    updatePrayerTimes();
  }

  void getCounterIndex() async {
    _prefs = await SharedPreferences.getInstance();
    countIndex = _prefs.getInt("indexCunt") ?? 13;
  }

  Future<void> saveCounterIndex(int index) async {
    await _prefs.setInt("indexCunt", index);
    updatePrayerTimes();
  }

  // Method to save latitude and longitude to shared preferences
  Future<void> saveCoordinatesToPrefs(double latitude, double longitude) async {
    await _prefs.setDouble('latitude', latitude);
    await _prefs.setDouble('longitude', longitude);
    latitude = latitude;
    longitude = longitude;
    updatePrayerTimes();
  }

  void setCustomPrayerTimes(DateTime dateTime22) {
    dateTime = dateTime22;
    emit(state);
  }

  void updatePrayerTimes() {
    getCounterIndex();
    // Specify the calculation parameters for prayer times
    PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
    params.madhab = PrayerMadhab.hanafi;

    // Create a PrayerTimes instance for the specified location
    PrayerTimes prayerTimes = PrayerTimes(
      coordinates: Coordinates(latitude, longitude),
      calculationParameters: params,
      precision: true,
      locationName: 'Asia/Tashkent',
      dateTime: dateTime,
    );

    // Update prayer times in the state
    emit([
      prayerTimes.fajrStartTime.toString(),
      prayerTimes.sunrise.toString(),
      prayerTimes.dhuhrStartTime.toString(),
      prayerTimes.asrStartTime.toString(),
      prayerTimes.maghribStartTime.toString(),
      prayerTimes.ishaStartTime.toString(),
    ]);
  }

  void toggleSelectedIndex(int index) {
    if (selectedIndex.contains(index)) {
      selectedIndex.remove(index);
    } else {
      selectedIndex.add(index);
    }
    emit(List.from(state)); // O'zgarishlarni bildirish
  }

  String extractTime(String dateTimeString) {
    List<String> parts = dateTimeString.split(' ');
    if (parts.length >= 2) {
      String timePart = parts[1];
      List<String> timeParts = timePart.split(':');
      if (timeParts.length >= 2) {
        String hour = timeParts[0];
        String minute = timeParts[1];
        return '$hour:$minute';
      }
    }
    return '';
  }
  //NAme finder praer
  int findIndex(List<String> date, String targetTime) {
    for (int i = 0; i < date.length; i++) {
      if (date[i] == targetTime) {
        print("${date[i]} == $targetTime");
        return i;
      }
    }
    return 0; // Agar berilgan vaqt topilmagan bo'lsa
  }
//Update metod
  void updateTime(String namozVaqti, BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);
    int timeSystem = int.parse(formattedTime.split(':')[0]);
    int timeSystemMin = int.parse(formattedTime.split(':')[1]);
    List<String> time = namozVaqti.split(":");
    int timeApp = int.parse(time[0]);
    int timeAppMin = int.parse(time[1]);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;

    // Emit updated time values to the state
    emit([
      timeSystem.toString(),
      timeSystemMin.toString(),
      timeApp.toString(),
      timeAppMin.toString(),
      size.width.toString(),
      size.height.toString(),
    ]);
  }

  void update() {
    emit(state);
  }

  //Cordinates Saved

  void country(index) {
    switch (index) {
      case 0:
        latitude = 40.7831;
        longitude = 72.3485;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 1:
        latitude = 39.7753;
        longitude = 64.4259;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 2:
        latitude = 40.3792;
        longitude = 71.7889;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 3:
        latitude = 40.1156;
        longitude = 67.8424;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 4:
        latitude = 40.4558;
        longitude = 68.7900;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 5:
        latitude = 41.3775;
        longitude = 60.3378;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 6:
        latitude = 40.9987;
        longitude = 71.6729;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 7:
        latitude = 40.0846;
        longitude = 65.3798;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 8:
        latitude = 38.5225;
        longitude = 66.7765;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 9:
        latitude = 43.9159;
        longitude = 59.6780;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 10:
        latitude = 39.6542;
        longitude = 66.9597;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 11:
        latitude = 37.2631;
        longitude = 67.2804;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 12:
        latitude = 41.2995;
        longitude = 69.2401;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      case 13:
        latitude = 41.2995;
        longitude = 69.2401;
        saveCoordinatesToPrefs(latitude, longitude);
        updatePrayerTimes();
        break;
      default:
        print('Invalid province name');
    }
  }

//Eng yaqin namoz vaqti

  String getCurrentTime() {
    return DateFormat("HH:mm")
        .format(DateTime.now()); // Hozirgi vaqtning formati
  }

  String findClosestPrayerTime(List<String> prayerTimes, String currentTime) {
    List<int> current = timeToMinutes(currentTime);
    int currentMinutes = current[0] * 60 + current[1];

    int closestTimeDiff = 24 * 60; // Yuqori hisoblash uchun katta qiymat
    String closestTime = "";

    for (String time in prayerTimes) {
      List<int> prayer = timeToMinutes(time);
      int prayerMinutes = prayer[0] * 60 + prayer[1];

      int timeDiff = (prayerMinutes - currentMinutes).abs();
      if (timeDiff < closestTimeDiff && prayerMinutes > currentMinutes) {
        closestTimeDiff = timeDiff;
        closestTime = time;
      }
    }
    return closestTime;
  }

  List<int> timeToMinutes(String time) {
    List<String> parts = time.split(":");
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    return [hours, minutes];
  }

  int calculateTimeDifference(String time1, String time2) {
    List<String> time1Parts = time1.split(':');
    int hour1 = int.parse(time1Parts[0]);
    int minute1 = int.parse(time1Parts[1]);

    List<String> time2Parts = time2.split(':');
    int hour2 = int.parse(time2Parts[0]);
    int minute2 = int.parse(time2Parts[1]);

    int totalMinutes1 = (hour1 * 60) + minute1;
    int totalMinutes2 = (hour2 * 60) + minute2;

    return (totalMinutes1 - totalMinutes2).abs();
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Yanvar';
      case 2:
        return 'Fevral';
      case 3:
        return 'Mart';
      case 4:
        return 'Aprel';
      case 5:
        return 'May';
      case 6:
        return 'Iyun';
      case 7:
        return 'Iyul';
      case 8:
        return 'Avgust';
      case 9:
        return 'Sentabr';
      case 10:
        return 'Oktabr';
      case 11:
        return 'Noyabr';
      case 12:
        return 'Dekabr';
      default:
        return '';
    }
  }


  Route createRoute(Widget widget,Color color) {
    return PageRouteBuilder(
      barrierColor:color,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
