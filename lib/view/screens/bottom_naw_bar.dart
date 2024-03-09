import 'dart:io';

import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/view/screens/home_page.dart';
import 'package:bugun_juma/view/screens/kun_tartibi.dart';
import 'package:bugun_juma/view/screens/namoz_vaqtlari.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class BottomNawBar extends StatefulWidget {
  const BottomNawBar({Key? key}) : super(key: key);

  @override
  State<BottomNawBar> createState() => _BottomNawBarState();
}

class _BottomNawBarState extends State<BottomNawBar> {
  int i = 0;
  List<Widget> pages = [HomePage(), NamozVaqtlari(), KunTartibi()];

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            final value = await showDialog<bool>(
              context: context,
              builder: (context) => AlderDilaogNew(state),
            );
            if (value != null) {
              return Future.value(value);
            } else {
              return Future.value(false);
            }
          },
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              elevation: 20,
              backgroundColor: Colors.white,
              selectedIconTheme: IconThemeData(size:size.height*0.05,),
              selectedLabelStyle: const TextStyle(fontSize: 0),
              selectedItemColor: state == false
                  ? const Color(0xFF41966F)
                  : const Color(0xFFF540EC),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(FlutterIslamicIcons.solidMosque),
                  label: "",
                ),
                BottomNavigationBarItem(
                    icon: Icon(FlutterIslamicIcons.solidSajadah), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(FlutterIslamicIcons.calendar), label: ""),
              ],
              currentIndex: i,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(
                      () {
                    i = index;
                  },
                );
              },
            ),
            body: pages[i],
          ),
        );
      },
    );
  }

  Widget AlderDilaogNew(bool state) {
    return AlertDialog(
      backgroundColor: state == false
          ? const Color(0xFF41966F)
          : const Color(0xFFF540EC),
      title:  Card(
        color: state == false
            ? const Color(0xFF41966F)
            : const Color(0xFFF540EC),
        elevation: 20,
        shadowColor: Colors.grey,
      ),
      content: const Text("Dasturdan chiqadsizmi?",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600)),
      actions: [
        ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.grey),
          ),
          onPressed: () {
            Navigator.of(context).pop(exit(1));
          },
          child: const Text(
            "Ha",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.grey),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text(
            "Yo'g'e",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

}
