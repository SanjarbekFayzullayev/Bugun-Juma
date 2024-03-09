import 'dart:convert';
import 'dart:io'; // Import 'dart:io' for SecurityContext
import 'package:audioplayers/audioplayers.dart';
import 'package:bugun_juma/main_view_model/cubit/hat_chop_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/index_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/name_cubit.dart';
import 'package:bugun_juma/main_view_model/quran_model/quran.dart';
import 'package:bugun_juma/view/screens/selected_sura.dart';
import 'package:bugun_juma/view/widgets/home_page/banner_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main_view_model/cubit/male_cubit.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  late NameCubit _cubit;
  late HatChopCubit _hatChopCubit;

  late IndexCubit _indexCubit;
  final player = AudioPlayer();
  bool isPlaying = false;
  bool wait = false;

  var surahIndex;
  bool isLoading = false;
  int qoriNumber = 5;
  Duration? duration = Duration.zero;
  Duration? position = Duration.zero;
  late SharedPreferences loginData;

  @override
  void initState() {
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
    _cubit = context.read<NameCubit>();
    _hatChopCubit = context.read<HatChopCubit>();
    _indexCubit = context.read<IndexCubit>();
    _indexCubit.loadSelected();
    super.initState();
  }

  List<String> indexCubit = [];

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return BlocBuilder<IndexCubit, List<String>>(
      builder: (context, indexCubit) {
        return BlocBuilder<NameCubit, String>(
          builder: (context, state) {
            return BlocBuilder<HatChopCubit, String>(
              builder: (context, surahName) {
                return BlocBuilder<MaleCubit, bool>(
                  builder: (context, state) {
                    return Scaffold(
                      floatingActionButton: FloatingActionButton(
                          backgroundColor: state == false
                              ? const Color(0xFF41966F)
                              : const Color(0xFFFF88F9),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const SelectSurah(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.bookmark,
                            size: size.height * 0.028,
                            color: Colors.white,
                          )),
                      body: FutureBuilder<Quran>(
                        future: _cubit.futureQuran,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: double.infinity,
                              color: state == false
                                  ? const Color(0xFF41966F)
                                  : const Color(0xFFFF88F9),
                              child: SafeArea(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.all(size.height * 0.01),
                                      child: SizedBox(
                                        height: size.height * 0.06,
                                        child: TextField(
                                          cursorHeight: size.height * 0.046,
                                          cursorOpacityAnimates: true,
                                          onChanged: (value) {
                                            setState(() {
                                              _cubit.filterQuran(value);
                                            });
                                          },
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          cursorColor: Colors.white60,
                                          controller: search,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.height * 0.08),
                                              ),
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.height * 0.08),
                                              ),
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            hintText: 'Sura qidiring...',
                                            hintStyle: TextStyle(
                                                fontSize: size.height * 0.02,
                                                color: Colors.white60,
                                                fontWeight: FontWeight.normal,
                                                textBaseline:
                                                    TextBaseline.alphabetic),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: snapshot.data!.data!.length,
                                        itemBuilder: (context, index) {
                                          final data =
                                              snapshot.data!.data![index];
                                          return Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.height * 0.044)),
                                            shadowColor: Colors.black,
                                            elevation: size.width * 0.01,
                                            child: Container(
                                              width: size.width * 0.86,
                                              height: size.height * 0.28,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                        size.height * 0.044),
                                                  ),
                                                  color: Colors.white),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        "${data.nomor} | ${data.namaLatin}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                size.width *
                                                                    0.042),
                                                      ),
                                                      Text(
                                                        data.nama!,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                size.width *
                                                                    0.042),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        "Nozil bo'lgan:${data.tempatTurun}",
                                                        style: TextStyle(
                                                            color: state ==
                                                                    false
                                                                ? const Color(
                                                                    0xFF41966F)
                                                                : const Color(
                                                                    0xFFFF88F9),
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                size.width *
                                                                    0.032),
                                                      ),
                                                      Text(
                                                        "Oyatlar soni :${data.jumlahAyat}",
                                                        style: TextStyle(
                                                            color: state ==
                                                                    false
                                                                ? const Color(
                                                                    0xFF41966F)
                                                                : const Color(
                                                                    0xFFFF88F9),
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                size.width *
                                                                    0.032),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          String url = qoriNumber ==
                                                                  1
                                                              ? data.audioFull!
                                                                  .s01!
                                                              : qoriNumber == 2
                                                                  ? data
                                                                      .audioFull!
                                                                      .s02!
                                                                  : qoriNumber ==
                                                                          3
                                                                      ? data
                                                                          .audioFull!
                                                                          .s03!
                                                                      : qoriNumber ==
                                                                              4
                                                                          ? data
                                                                              .audioFull!
                                                                              .s04!
                                                                          : data
                                                                              .audioFull!
                                                                              .s05!;
                                                          print(url);
                                                          _hatChopCubit
                                                              .downloadMedia(
                                                                  url,
                                                                  state,
                                                                  "${data.nomor}${data.namaLatin!}.mp3",
                                                                  context);
                                                        },
                                                        icon: Icon(
                                                          Icons.download,
                                                          size: size.height *
                                                              0.028,
                                                          color: state == false
                                                              ? const Color(
                                                                  0xFF41966F)
                                                              : const Color(
                                                                  0xFFFF88F9),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              formatTime(
                                                                isPlaying ==
                                                                            true &&
                                                                        surahIndex ==
                                                                            index
                                                                    ? duration!
                                                                    : const Duration(
                                                                        seconds:
                                                                            0),
                                                              ),
                                                              style: TextStyle(
                                                                  fontSize: size
                                                                          .height *
                                                                      0.016),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.4,
                                                              child: Slider(
                                                                min: 0,
                                                                max: isPlaying ==
                                                                            true &&
                                                                        surahIndex ==
                                                                            index
                                                                    ? duration
                                                                            ?.inSeconds
                                                                            .toDouble() ??
                                                                        0
                                                                    : 0,
                                                                value: isPlaying ==
                                                                            true &&
                                                                        surahIndex ==
                                                                            index
                                                                    ? position
                                                                            ?.inSeconds
                                                                            .toDouble() ??
                                                                        0
                                                                    : 0,
                                                                activeColor: state ==
                                                                        false
                                                                    ? const Color(
                                                                        0xFF41966F)
                                                                    : const Color(
                                                                        0xFFFF88F9),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    position = Duration(
                                                                        seconds:
                                                                            value.toInt());
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Text(
                                                              formatTime(
                                                                isPlaying ==
                                                                            true &&
                                                                        surahIndex ==
                                                                            index
                                                                    ? position!
                                                                    : const Duration(
                                                                        seconds:
                                                                            0),
                                                              ),
                                                              style: TextStyle(
                                                                  fontSize: size
                                                                          .height *
                                                                      0.016),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          if (indexCubit.contains(
                                                              (data.nomor! - 1)
                                                                  .toString())) {
                                                            setState(() {
                                                              _indexCubit.removeItem(
                                                                  (data.nomor! -
                                                                          1)
                                                                      .toString());
                                                              print(indexCubit);
                                                            });
                                                          } else {
                                                            setState(() {
                                                              indexCubit.add(
                                                                  (data.nomor! -
                                                                          1)
                                                                      .toString());
                                                              _indexCubit
                                                                  .saveSelected(
                                                                      indexCubit);
                                                            });
                                                          }
                                                        },
                                                        icon: Icon(
                                                          indexCubit.contains(
                                                                  (data.nomor! -
                                                                          1)
                                                                      .toString())
                                                              ? Icons.bookmark
                                                              : Icons
                                                                  .bookmark_border,
                                                          size: size.height *
                                                              0.028,
                                                          color: state == false
                                                              ? const Color(
                                                                  0xFF41966F)
                                                              : const Color(
                                                                  0xFFFF88F9),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          isLoading == false
                                                              ? inkWell(
                                                                  data.audioFull!
                                                                      .s05!,
                                                                  index,
                                                                  data.namaLatin!,
                                                                  5)
                                                              : const SizedBox();
                                                          print(qoriNumber);
                                                        },
                                                        child: AudioBannerLogo(
                                                          "assets/imgs/sheyx/besh.png",
                                                          isLoading == true &&
                                                                  surahIndex ==
                                                                      index &&
                                                                  qoriNumber ==
                                                                      5
                                                              ? Icons.refresh
                                                              : isPlaying ==
                                                                          true &&
                                                                      surahIndex ==
                                                                          index &&
                                                                      qoriNumber ==
                                                                          5
                                                                  ? Icons.pause
                                                                  : Icons
                                                                      .play_arrow,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          isLoading == false
                                                              ? inkWell(
                                                                  data.audioFull!
                                                                      .s01!,
                                                                  index,
                                                                  data.namaLatin!,
                                                                  1)
                                                              : const SizedBox();
                                                          print(qoriNumber);
                                                        },
                                                        child: AudioBannerLogo(
                                                          "assets/imgs/sheyx/bir.png",
                                                          isLoading == true &&
                                                                  surahIndex ==
                                                                      index &&
                                                                  qoriNumber ==
                                                                      1
                                                              ? Icons.refresh
                                                              : isPlaying ==
                                                                          true &&
                                                                      surahIndex ==
                                                                          index &&
                                                                      qoriNumber ==
                                                                          1
                                                                  ? Icons.pause
                                                                  : Icons
                                                                      .play_arrow,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          isLoading == false
                                                              ? inkWell(
                                                                  data.audioFull!
                                                                      .s02!,
                                                                  index,
                                                                  data.namaLatin!,
                                                                  2)
                                                              : const SizedBox();
                                                        },
                                                        child: AudioBannerLogo(
                                                          "assets/imgs/sheyx/ikki.png",
                                                          isPlaying == true &&
                                                                  surahIndex ==
                                                                      index &&
                                                                  qoriNumber ==
                                                                      2
                                                              ? Icons.pause
                                                              : isLoading ==
                                                                          true &&
                                                                      surahIndex ==
                                                                          index &&
                                                                      qoriNumber ==
                                                                          2
                                                                  ? Icons
                                                                      .refresh
                                                                  : Icons
                                                                      .play_arrow,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          isLoading == false
                                                              ? inkWell(
                                                                  data.audioFull!
                                                                      .s03!,
                                                                  index,
                                                                  data.namaLatin!,
                                                                  3)
                                                              : const SizedBox();
                                                        },
                                                        child: AudioBannerLogo(
                                                          "assets/imgs/sheyx/uch.png",
                                                          isPlaying == true &&
                                                                  surahIndex ==
                                                                      index &&
                                                                  qoriNumber ==
                                                                      3
                                                              ? Icons.pause
                                                              : isLoading ==
                                                                          true &&
                                                                      surahIndex ==
                                                                          index &&
                                                                      qoriNumber ==
                                                                          3
                                                                  ? Icons
                                                                      .refresh
                                                                  : Icons
                                                                      .play_arrow,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          isLoading == false
                                                              ? inkWell(
                                                                  data.audioFull!
                                                                      .s04!,
                                                                  index,
                                                                  data.namaLatin!,
                                                                  4)
                                                              : const SizedBox();
                                                        },
                                                        child: AudioBannerLogo(
                                                          "assets/imgs/sheyx/tort.png",
                                                          isPlaying == true &&
                                                                  surahIndex ==
                                                                      index &&
                                                                  qoriNumber ==
                                                                      4
                                                              ? Icons.pause
                                                              : isLoading ==
                                                                          true &&
                                                                      surahIndex ==
                                                                          index &&
                                                                      qoriNumber ==
                                                                          4
                                                                  ? Icons
                                                                      .refresh
                                                                  : Icons
                                                                      .play_arrow,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Container(
                              width: double.infinity,
                              color: state == false
                                  ? const Color(0xFF41966F)
                                  : const Color(0xFFFF88F9),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wifi_off_sharp,
                                      size: size.height * 0.08,
                                      color: Colors.white),
                                  Text(
                                    "Internet mavjud emas!",
                                    style: TextStyle(
                                        fontSize: size.height * 0.03,
                                        color: Colors.white),
                                  ),
                                  TextButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black38),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _cubit.update();
                                      });
                                    },
                                    child: Text(
                                      "Takrorlash",
                                      style: TextStyle(
                                          fontSize: size.height * 0.03,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                                color: state == false
                                    ? const Color(0xFF41966F)
                                    : const Color(0xFFFF88F9)),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> playSound(String url) async {
    await player.play(UrlSource(url));
  }

  void inkWell(
      String audioUrl, int index, String audioName, int qoriNumbe) async {
    if (isPlaying) {
      setState(() {
        surahIndex = index;
        qoriNumber = qoriNumbe;
        isLoading = false;
      });
      await player.stop();
    } else {
      setState(() {
        surahIndex = index;
        qoriNumber = qoriNumbe;
        isLoading = true;
      });
      await playSound(audioUrl);
    }
    setState(() {
      isLoading = false;
    });
    _hatChopCubit.setHatChop(audioUrl, audioName);
    print("Saqlandi");
  }

  String formatTime(Duration duration) {
    String twDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twDigits(duration.inHours);
    final minutes = twDigits(duration.inMinutes.remainder(60));
    final seconds = twDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void dispose() {
    // Dispose the audio player when the widget is disposed
    _hatChopCubit.getHatChop();
    player.release();
    player.dispose();
    super.dispose();
  }
}
//
