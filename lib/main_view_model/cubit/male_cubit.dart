import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaleCubit extends Cubit<bool> {
  MaleCubit() : super(false);

  void getMale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool malePreference = prefs.getBool('male') ?? false;
    emit(malePreference);
    print(malePreference);
  }

  void setMale(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setBool('male', value);
    emit(value);
    print(value);
  }


}
