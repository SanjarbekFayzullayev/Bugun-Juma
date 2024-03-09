import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewCubit extends Cubit<int> {
  ViewCubit() : super(20);

  void getView() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int view = prefs.getInt('view') ?? 20;
    emit(view);
    print(view);
  }

  void setView(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("view");
    prefs.setInt('view', value);
    emit(value);
    print(value);
  }


}