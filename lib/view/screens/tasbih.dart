import 'dart:math';

import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/tasbih_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/tasbih_total_cubit.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vibration/vibration.dart';

class TasbihPage extends StatefulWidget {
  const TasbihPage({Key? key}) : super(key: key);

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage> {
  late TasbihCubit cubit = context.read<TasbihCubit>();
  late TasbihTotalCubit cubit2 = context.read<TasbihTotalCubit>();
  final controller = ConfettiController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    cubit.getCount();
    cubit.getVolume();
    cubit.getVibration();
    cubit2.getTotal();
    cubit.getAllCount();
    cubit.getRecord();
    super.initState();
  }

  Future<void> _startConfetti() async {
    controller.play();
    await Future.delayed(
      const Duration(seconds: 6),
    );
    if (mounted) {
      controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return BlocBuilder<TasbihCubit, int>(
          builder: (context, tasbih) {
            return BlocBuilder<TasbihTotalCubit, int>(
              builder: (context, total) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Scaffold(
                      body: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: state == false
                                ? [
                                    const Color(0xFF193A2B),
                                    const Color(0xFF41966E),
                                    const Color(0xFF52BD8B),
                                  ]
                                : [
                                    const Color(0xFF330D31),
                                    const Color(0xFF852380),
                                    const Color(0xFFBB31B4),
                                  ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(size.height * 0.01),
                                child: Container(
                                  height: size.height * 0.08,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.04),
                                  ),
                                child:  Padding(
                                  padding:  EdgeInsets.all(size.height * 0.01),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Jami: ${cubit.allCount}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.height * 0.03,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Maqsad: ${cubit.record}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.height * 0.03,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.volume==true? cubit.playSound("audios/tasbih.mp3"):const SizedBox();
                                  Vibration.vibrate(duration: 1);
                                  if (cubit.allCount == cubit.record) {
                                    _startConfetti();
                                    cubit.volume==true? cubit.playSound("audios/confatti.mp3"):const SizedBox();
                                    switch(cubit.record){
                                      case 100:
                                        cubit.setRecord(500);
                                        cubit.getRecord();
                                    break;
                                      case 500:
                                        cubit.setRecord(1000);
                                        cubit.getRecord();
                                        break;
                                      case 1000:
                                        cubit.setRecord(5000);
                                        cubit.getRecord();
                                        break;
                                      case 5000:
                                        cubit.setRecord(10000);
                                        cubit.getRecord();
                                        break;
                                      case 10000:
                                        cubit.setRecord(50000);
                                        cubit.getRecord();
                                        break;
                                    }
                                  }
                                  cubit.setAllCount(++cubit.allCount);
                                  tasbih++;
                                  cubit.setCount(tasbih, total);

                                },
                                child: CircularStepProgressIndicator(
                                  totalSteps: total,
                                  currentStep: tasbih,
                                  stepSize: size.height * 0.01,
                                  selectedColor: state == false? Colors.greenAccent:Colors.purpleAccent,
                                  unselectedColor: Colors.grey[200],
                                  padding: 0,
                                  width: size.height * 0.34,
                                  height: size.height * 0.34,
                                  selectedStepSize: 15,
                                  roundedCap: (_, __) => true,
                                  child: Center(
                                    child: Text(
                                      "${tasbih.toString()}/${total.toString()}",
                                      style: TextStyle(
                                          color: Colors.grey[200],
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.height * 0.06),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(size.height * 0.008),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.08,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.04),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cubit.setCount(0, total);
                                            cubit.setAllCount(0);
                                          cubit.getAllCount();
                                            },
                                          icon: Icon(
                                            Icons.restart_alt,
                                            color: Colors.white,
                                            size: size.height * 0.06,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              cubit.volume=!cubit.volume;
                                            });
                                            cubit.setVolume(cubit.volume);
                                          },
                                          icon: Icon(
                                           cubit.volume==true? Icons.volume_up:Icons.volume_off,
                                            color: Colors.white,
                                            size: size.height * 0.06,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              cubit.vibration=!cubit.vibration;
                                            });
                                            cubit.setVolume(cubit.vibration);
                                          },
                                          icon: Icon(
                                            cubit.vibration==true?Icons.vibration:Icons.phone_android_outlined,
                                            color: Colors.white,
                                            size: size.height * 0.06,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (total == 33) {
                                              cubit2.setTotal(99);
                                            } else {
                                              cubit2.setTotal(33);
                                              cubit.setCount(0, 33);
                                            }
                                          },
                                          icon: Icon(
                                            total == 33
                                                ? FlutterIslamicIcons.tasbih2
                                                : FlutterIslamicIcons.allah99,
                                            color: Colors.white,
                                            size: size.height * 0.06,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ConfettiWidget(
                      confettiController: controller,
                      numberOfParticles: 50,
                      shouldLoop: false,
                      blastDirectionality: BlastDirectionality.explosive,
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
