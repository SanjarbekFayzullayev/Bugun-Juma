import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/view/screens/setting_page.dart';
import 'package:bugun_juma/view/widgets/namoz_vaqtlari_page/namoz_vaqtlari_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

import '../../main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import '../widgets/namoz_vaqtlari_page/main_widget.dart';

class NamozVaqtlari extends StatefulWidget {
  NamozVaqtlari({Key? key}) : super(key: key);

  @override
  State<NamozVaqtlari> createState() => _NamozVaqtlariState();
}

class _NamozVaqtlariState extends State<NamozVaqtlari> {
  late String lat;
  late String long;
  DateTime _selectedDay = DateTime.now();
  late NamozVaqtlariListCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<NamozVaqtlariListCubit>();
    _cubit.updatePrayerTimes();
    _cubit.initPrefs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<MaleCubit, bool>(
        builder: (context, state) {
          return BlocBuilder<NamozVaqtlariListCubit, List<String>>(
            builder: (context, namozVaqtlari) {
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: size.height * 0.022,
                          left: size.height * 0.022),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: const Color(0xFFF8C45D),
                                size: size.height * 0.036,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Joylashuv",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: size.height * 0.02,
                                    ),
                                  ),
                                  Text(
                                    _cubit.viloyatlar[_cubit.countIndex],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.026,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SettingPage(),
                                ),
                              );
                            },
                            icon: Icon(Icons.settings,
                                color: Colors.grey, size: size.height * 0.04),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: size.width * 0.002,
                      endIndent: size.width * 0.09,
                      indent: size.width * 0.09,
                    ),
                    SizedBox(
                      width: size.width * 0.86,
                      child: WeeklyDatePicker(
                       weekdays: const ["Du","Se","Chor","Pay","Ju","Shan","Yak",],
                        backgroundColor: Colors.white,
                        selectedDigitBackgroundColor: state == false
                            ? const Color(0xFF41966F)
                            : const Color(0xFFFB6CF4),
                        enableWeeknumberText: false,
                        selectedDay: _cubit.dateTime,
                        // DateTime
                        changeDay: (value) {
                          setState(() {
                            _cubit.updateDate(value);
                          });
                        },
                      ),
                    ),
                    const MainWidgetNPage(),
                    NamozVaqtlariListWidget(),
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
