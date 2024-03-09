import 'package:audioplayers/audioplayers.dart';
import 'package:bugun_juma/main_view_model/cubit/hat_chop_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/name_cubit.dart';
import 'package:bugun_juma/main_view_model/quran_model/quran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main_view_model/cubit/male_cubit.dart';

class HatChopWidget extends StatefulWidget {
  const HatChopWidget({Key? key}) : super(key: key);

  @override
  State<HatChopWidget> createState() => _HatChopWidgetState();
}

class _HatChopWidgetState extends State<HatChopWidget> {
  late NameCubit _cubit;
  late HatChopCubit _hatChopCubit;
  Duration? duration = Duration.zero;
  Duration? position = Duration.zero;
  bool isPlaying = false;
  final player = AudioPlayer();
  @override
  void initState() {
    _cubit = context.read<NameCubit>();
    _hatChopCubit = context.read<HatChopCubit>();
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
      player.onPositionChanged.listen((newPosition) {
        setState(() {
          position = newPosition;
        });
      });
    });
    _hatChopCubit.getHatChop();
    player.stop();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return BlocBuilder<NameCubit, String>(
      builder: (context, state) {
        return BlocBuilder<HatChopCubit, String>(
  builder: (context, surahName) {
    return BlocBuilder<MaleCubit, bool>(
          builder: (context, state) {
            return Container(
              height: size.height * 0.12,
              width: size.width * 0.86,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.height * 0.03),
                gradient: LinearGradient(
                  colors: state == false
                      ? [
                    const Color(0xFF41966F),
                    const Color(0xFF63A988),
                    const Color(0xFF80B99F),
                  ]
                      : [
                    const Color(0xFFF540EC),
                    const Color(0xFFFB6CF4),
                    const Color(0xFFFF8CF9),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    color: Colors.white,
                    elevation: size.height * 0.01,
                    shadowColor: Colors.black,
                    margin: EdgeInsets.all(size.height * 0.0001),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(size.height * 0.03),
                        topLeft: Radius.circular(size.height * 0.03),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () async{
                        String url=_hatChopCubit.surahUrl!;
                        if (isPlaying) {
                          await player.stop();
                        } else {
                          await playSound(url);
                        }

                      },
                      icon: Icon(isPlaying?Icons.pause:Icons.play_arrow,
                          color: state == false
                              ? const Color(0xFF41966F)
                              : const Color(0xFFF540EC),
                          size: size.height * 0.06),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "So'ngi tinglangan sura.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height * 0.02),
                      ),
                      Text(
                        surahName==''?"Hozircha yo'q":surahName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * 0.02),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.navigate_next_outlined,
                    color: Colors.white,
                    size: size.height * 0.05,
                  )
                ],
              ),
            );;
          },
        );
  },
);
      },
    );
  }
  Future<void> playSound(
      String url) async {
    player.stop();
    await player.play(UrlSource(url));
  }
  @override
  void dispose() {
    // Dispose the audio player when the widget is disposed
    player.dispose();
    super.dispose();
  }
}
