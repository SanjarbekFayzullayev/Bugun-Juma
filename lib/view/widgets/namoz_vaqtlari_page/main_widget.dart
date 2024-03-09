import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import 'package:bugun_juma/view/screens/compass_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hijri/hijri_calendar.dart';

class MainWidgetNPage extends StatefulWidget {
  const MainWidgetNPage({Key? key}) : super(key: key);

  @override
  State<MainWidgetNPage> createState() => _MainWidgetNPageState();
}

class _MainWidgetNPageState extends State<MainWidgetNPage> {
  late NamozVaqtlariListCubit _cubit;
  late MaleCubit _cubit2;

  @override
  void initState() {
    _cubit2 = context.read<MaleCubit>();
    _cubit2.getMale();
    _cubit = context.read<NamozVaqtlariListCubit>();
    _cubit.updatePrayerTimes();
    _cubit.initPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _today = HijriCalendar.now();
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return BlocBuilder<NamozVaqtlariListCubit, List<String>>(
          builder: (context, namozVaqtlari) {
            var namozVatlariMin = [
              _cubit.extractTime(namozVaqtlari[0]),
              _cubit.extractTime(namozVaqtlari[1]),
              _cubit.extractTime(namozVaqtlari[2]),
              _cubit.extractTime(namozVaqtlari[3]),
              _cubit.extractTime(namozVaqtlari[4]),
              _cubit.extractTime(namozVaqtlari[5])
            ];

            String currentTime = _cubit.getCurrentTime(); // Hozirgi vaqt
            String closestPrayerTime =
                _cubit.findClosestPrayerTime(namozVatlariMin, currentTime);
            int differenceInMinutes = _cubit.calculateTimeDifference(
              closestPrayerTime == "" ? currentTime : closestPrayerTime,
              currentTime,
            );
            _cubit.findClosestPrayerTime(namozVatlariMin, currentTime);
            int indexa = _cubit.findIndex(namozVatlariMin,  closestPrayerTime == ""
                ? namozVatlariMin[0]
                : closestPrayerTime);

            return Card(
              shadowColor: Colors.black,
              elevation: size.height * 0.008,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(size.height * 0.04),
                ),
              ),
              child: Container(
                width: size.width * 0.86,
                height: size.height * 0.28,
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(size.height * 0.04),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.height * 0.022),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hijri yil",
                                style: TextStyle(
                                    fontSize: size.height * 0.014,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _today.toFormat("dd MMMM yyyy"),
                                style: TextStyle(
                                    fontSize: size.height * 0.0182,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${_cubit.names[indexa]} namoziga",
                                style: TextStyle(
                                    fontSize: size.height * 0.014,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${differenceInMinutes ~/ 60} soat ${differenceInMinutes % 60} minut qoldi",
                                style: TextStyle(
                                    fontSize: size.height * 0.0182,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                closestPrayerTime == ""
                                    ? namozVatlariMin[0]
                                    : closestPrayerTime,
                                style: TextStyle(
                                    fontSize: size.height * 0.062,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    _cubit.createRoute(
                                      const CompassScreen(),
                                        state==false? const Color(0xFF41966F):const Color(0xFFF540EC),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: size.height * 0.18,
                                  height: size.height * 0.04,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(size.height * 0.012),
                                      ),
                                      color: Colors.white),
                                  child: Text(
                                    "Qiblani toping",
                                    style: TextStyle(
                                        color: state == false
                                            ? const Color(0xFF41966F)
                                            : const Color(0xFFFB6CF4),
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.height * 0.02),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Card(
                            elevation: size.height * 0.018,
                            shadowColor: Colors.black,
                            shape: const BeveledRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    bottomRight: Radius.circular(18))),
                            child: Container(
                              height: size.height * 0.14,
                              width: size.height * 0.14,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: state == false
                                      ? [
                                          const Color(0xFF9DDBC3),
                                          Colors.white,
                                          const Color(0xFF9DDBC3),
                                        ]
                                      : [
                                          const Color(0xFFFB6CF4),
                                          Colors.white,
                                          const Color(0xFFFB6CF4),
                                        ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(size.height * 0.028),
                                  bottomRight:
                                      Radius.circular(size.height * 0.028),
                                ),
                              ),
                              child: Icon(
                                FlutterIslamicIcons.solidCrescentMoon,
                                color: state == false
                                    ? const Color(0xFF41966F)
                                    : const Color(0xFFF540EC),
                                size: size.height * 0.08,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
