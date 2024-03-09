import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbihTotalCubit extends Cubit<int> {
  TasbihTotalCubit() : super(33);

  void getTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int view = prefs.getInt('total') ?? 33;
    emit(view);
    print(view);
  }

  void setTotal(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("total");
    prefs.setInt('total', value);
    emit(value);
    print(value);
  }

}