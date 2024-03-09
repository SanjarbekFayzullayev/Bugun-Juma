import 'package:bugun_juma/main_view_model/cubit/name_cubit.dart';
import 'package:bugun_juma/view/screens/bottom_naw_bar.dart';
import 'package:bugun_juma/view/screens/lang_change_page.dart';
import 'package:bugun_juma/view/screens/login_page.dart';
import 'package:bugun_juma/view/widgets/lang_change_page_widget/lang_change_page_main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main_view_model/cubit/namoz_vaqtlari_cubit.dart';

class SettingPage extends StatefulWidget {
  bool openIn;

  SettingPage({this.openIn = false, Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late NamozVaqtlariListCubit _cubit;
  late NameCubit _cubit2;
  late int indexSelected;

  @override
  void initState() {
    _cubit = context.read<NamozVaqtlariListCubit>();
    _cubit.getCounterIndex();
    _cubit2=context.read<NameCubit>();
    _cubit.updatePrayerTimes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<NamozVaqtlariListCubit, List<String>>(
        builder: (context, namozVaqtlari) {
          return BlocBuilder<NameCubit, String>(
            builder: (context, stateName) {
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LangChangeMainWidget(
                        LanChangePage(widget.openIn),
                        "📍 Joylashuvni o'zgartrish",
                        _cubit.viloyatlar[_cubit.countIndex]),
                    LangChangeMainWidget(LoginPage(openIn: true),
                        "👤 Ma'lumotlarni o'zgartrish", stateName),
                   
                    LangChangeMainWidget(LoginPage(openIn: true),
                        "📖 Dastur xaqida", "Ma'lumotlar"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
