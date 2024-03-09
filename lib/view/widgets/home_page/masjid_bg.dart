import 'package:bugun_juma/main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import 'package:bugun_juma/view/screens/login_page.dart';
import 'package:bugun_juma/view/screens/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasjidBg extends StatelessWidget {
  MasjidBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return InkWell(
      onTap: ()  {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) =>
                SettingPage(),
          ),
        );
        // ignore: use_build_context_synchronously
      },
      child: Image.asset(
        "assets/imgs/masjidbg.png",
        width: size.width * 0.68,
      ),
    );
  }
}
