// ignore_for_file: use_build_context_synchronously

import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/name_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/name_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import 'package:bugun_juma/view/screens/bottom_naw_bar.dart';
import 'package:bugun_juma/view/screens/login_page.dart';
import 'package:bugun_juma/view/screens/setting_page.dart';
import 'package:bugun_juma/view/widgets/home_page/masjid_bg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderBg extends StatefulWidget {
  HeaderBg({Key? key}) : super(key: key);

  @override
  State<HeaderBg> createState() => _HeaderBgState();
}

class _HeaderBgState extends State<HeaderBg> {
  late bool maleOr;

  late NameCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<NameCubit>();
    _cubit.getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return Container(
          height: size.height * 0.26,
          width: double.infinity,
          decoration: BoxDecoration(
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
            image: const DecorationImage(
              image: AssetImage("assets/imgs/masjidbg.png"),fit: BoxFit.scaleDown
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(size.height * 0.06),
              bottomRight: Radius.circular(size.height * 0.06),
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.024),
            child: BlocBuilder<NameCubit, String>(
              builder: (context, stateName) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Assalomu aleykum",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: size.width * 0.58,
                              child: Text(
                                stateName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.028,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => SettingPage(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                )),
                            Container(
                              height: size.height * 0.052,
                              width: size.width * 0.09,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.042),
                                image: DecorationImage(
                                  image: AssetImage(state
                                      ? "assets/imgs/muslima.png"
                                      : "assets/imgs/muslim.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
