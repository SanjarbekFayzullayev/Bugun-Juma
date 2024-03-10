import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewCubit extends Cubit<int> {
  ViewCubit() : super(20);
  List<int> taskList=[];
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
  saveList(List<int> myList ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList('myIntListKey', myList.map((e) => e.toString()).toList());
    print('List saqlandi: $myList');
  }

  getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList('myIntListKey');
    if (stringList != null) {
      List<int> intList = stringList.map((e) => int.parse(e)).toList();
      taskList=intList;
    } else {
      print('List topilmadi');
    }
  }



}