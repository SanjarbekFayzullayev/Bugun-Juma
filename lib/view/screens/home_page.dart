import 'package:bugun_juma/main_view_model/cubit/hat_chop_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/name_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import 'package:bugun_juma/view/widgets/home_page/hat_chop.dart';
import 'package:bugun_juma/view/widgets/home_page/headr_bg.dart';
import 'package:bugun_juma/view/widgets/home_page/main_widget.dart';
import 'package:bugun_juma/view/widgets/home_page/masjid_bg.dart';
import 'package:bugun_juma/view/widgets/home_page/quotes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NamozVaqtlariListCubit _cubit;
  late NameCubit _cubit2;
  late HatChopCubit _hatChopCubit;

  @override
  void initState() {
    _cubit = context.read<NamozVaqtlariListCubit>();
    _cubit2 = context.read<NameCubit>();
    _hatChopCubit = context.read<HatChopCubit>();
    _cubit2.update();
    _hatChopCubit.getHatChop();
    _cubit.updatePrayerTimes();
    _cubit.initPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NamozVaqtlariListCubit, List<String>>(
      builder: (context, prayerTimes) {
        var namozVatlariMin = [
          _cubit.extractTime(prayerTimes[0]),
          _cubit.extractTime(prayerTimes[1]),
          _cubit.extractTime(prayerTimes[2]),
          _cubit.extractTime(prayerTimes[3]),
          _cubit.extractTime(prayerTimes[4]),
          _cubit.extractTime(prayerTimes[5])
        ];

        String currentTime = _cubit.getCurrentTime(); // Hozirgi vaqt
        String closestPrayerTime =
            _cubit.findClosestPrayerTime(namozVatlariMin, currentTime);
        int indexa = _cubit.findIndex(namozVatlariMin,  closestPrayerTime == ""
            ? namozVatlariMin[0]
            : closestPrayerTime);
        MediaQueryData mediaQueryData = MediaQuery.of(context);
        var size = mediaQueryData.size;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                 HeaderBg(),
                Align(
                  alignment: Alignment(0, size.height * 0.0009),
                  child: SizedBox(
                    height: size.height*0.72,
                    child: MainWidget(
                      closestPrayerTime == ""
                          ? namozVatlariMin[0]
                          : closestPrayerTime,
                      _cubit.viloyatlar[_cubit.countIndex],
                      _cubit,
                      _cubit.names[indexa]
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
