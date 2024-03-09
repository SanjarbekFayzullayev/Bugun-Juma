import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class TasbihCubit extends Cubit<int> {
  TasbihCubit() : super(0);
  int allCount=0;
  int record=100;
  var volume=true;
  var vibration=true;
  void getCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int view = prefs.getInt('count') ?? 0;
    emit(view);
    print(view);
  }

  void setCount(int value, int total) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (total < value) {
      emit(1);
      emit(state);
    } else {
      prefs.remove("count");
      prefs.setInt('count', value);

      emit(value);
      emit(state);
      print(value);
    }
  }

  void getAllCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    allCount= prefs.getInt('allCount') ?? 0;
    emit(state);
    print(allCount);
  }

  void setAllCount(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("allCount");
    prefs.setInt('allCount', value);
    emit(value);
    emit(state);
    print(value);
  }

  void getRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    record= prefs.getInt('record') ?? 100;
    emit(state);
    print(allCount);
  }

  void setRecord(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("record");
    prefs.setInt('record', value);

    emit(value);
    print(value);
  }

  void getVolume() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    volume= prefs.getBool('volume') ?? true;
    emit(state);
    print(allCount);
  }

  void setVolume(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("volume");
    prefs.setBool('volume', value);
    emit(state);
    print(value);
  }
  void getVibration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vibration= prefs.getBool('vibration') ?? true;
    emit(state);
    print(allCount);
  }

  void setVibration(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("vibration");
    prefs.setBool('vibration', value);
    emit(state);
    print(value);
  }
  Future<void> playSound(String path) async {
    final player = AudioPlayer();
    await player.play(AssetSource(path));
  }



}
