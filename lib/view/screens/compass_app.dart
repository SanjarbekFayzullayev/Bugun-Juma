import 'dart:async';
import 'dart:math';
import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({Key? key}) : super(key: key);

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  MagnetometerEvent _magnetometerEvent = MagnetometerEvent(
    0,
    0,
    0,
  );
  StreamSubscription? subscription;

  final player = AudioPlayer();
  late NamozVaqtlariListCubit _cubit;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlderDilaogNew();
            });
      },
    );
    _cubit = context.read<NamozVaqtlariListCubit>();
    _cubit.updatePrayerTimes();
    _cubit.initPrefs();
    subscription = magnetometerEvents.listen((event) {
      setState(() {
        _magnetometerEvent = event;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  double calculateDegrees(double x, double y) {
    double heading = atan2(x, y);
    heading = heading * 180 / pi;
    if (heading > 0) {
      heading -= 360;
    }
    return heading * -1;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final degrees =
        calculateDegrees(_magnetometerEvent.x, _magnetometerEvent.y);
    final angle = -1 * pi / 180 * degrees;

    return SafeArea(
      child: BlocBuilder<MaleCubit, bool>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: state == false
                  ? const Color(0xFF41966F)
                  : const Color(0xFFF540EC),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            backgroundColor: Colors.white,
            body: BlocBuilder<MaleCubit, bool>(
              builder: (context, state) {
                if (int.parse(degrees.toStringAsFixed(0)) > -0 &&
                        int.parse(degrees.toStringAsFixed(0)) < 20 ||
                    int.parse(degrees.toStringAsFixed(0)) > 200 &&
                        int.parse(degrees.toStringAsFixed(0)) < 290) {
                  state
                      ? playSound("audios/ayolAniqlandi.wav")
                      : playSound(
                          "audios/erkakAniqlandi.wav"); // playSound() metodi ishga tushadi
                }
                return BlocBuilder<NamozVaqtlariListCubit, List<String>>(
                  builder: (context, prayerTimes) {
                    return Container(
                      color: state == false
                          ? const Color(0xFF41966F)
                          : const Color(0xFFF540EC),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(size.height * 0.008),
                            child: Material(
                              elevation: size.height * 0.022,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(size.height * 0.28),
                              ),
                              color: int.parse(degrees.toStringAsFixed(0)) >
                                              -1 &&
                                          int.parse(
                                                  degrees.toStringAsFixed(0)) <
                                              20 ||
                                      int.parse(degrees.toStringAsFixed(0)) >
                                              200 &&
                                          int.parse(
                                                  degrees.toStringAsFixed(0)) <
                                              290
                                  ? state == false
                                      ? Colors.cyanAccent
                                      : const Color(0xFF780272)
                                  : Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(size.height * 0.028),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(size.height * 0.4),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Image.asset(state == false
                                          ?"assets/imgs/compass.png":"assets/imgs/compasswoman.png"),
                                      Transform.rotate(
                                        angle: angle,
                                        child: Image.asset(
                                            "assets/imgs/compassnedline.png"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(size.height * 0.008),
                            child: Text(
                              "Siz turga mintaqa\n${_cubit.viloyatlar[_cubit.countIndex]}(shim.keng:${_cubit.latitude}/sharq.urun${_cubit.longitude})",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> playSound(String path) async {
    Vibration.vibrate();
    await player.play(AssetSource(path));
  }

  Widget AlderDilaogNew() {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.white70,
          title: Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: state == false
                  ? const Color(0xFF41966F)
                  : const Color(0xFFF540EC),
            ),
            child: Column(
              children: [
                Text(
                  "Qiblani to'g'ri ko'rsatishi uchun mubil qurilmani 8(sakkiz) raqami shaklida aylantring.",
                  style: TextStyle(
                      fontSize: size.height * 0.02, color: Colors.white),
                ),
                Text(
                  "Eslatma! Ushbu funksiya bazi bir qurulmalarda ishlamasligi mumkin va test holatida ishlamoqda.",
                  style: TextStyle(
                      fontSize: size.height * 0.02, color: Colors.white),
                ),
              ],
            ),
          ),
          content: Image.asset(state == false
              ? "assets/imgs/alderdalog/compassdialog.png":"assets/imgs/alderdalog/compassdialogwoman.png"),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  state == false
                      ? const Color(0xFF41966F)
                      : const Color(0xFFF540EC),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "Xo'p",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
