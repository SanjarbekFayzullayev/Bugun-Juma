import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import 'package:bugun_juma/main_view_model/data_base/data_base_hleper.dart';
import 'package:bugun_juma/main_view_model/data_base/muslim_task.dart';
import 'package:bugun_juma/view/screens/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class KunTartibi extends StatefulWidget {
  KunTartibi({Key? key}) : super(key: key);

  @override
  State<KunTartibi> createState() => _KunTartibiState();
}

class _KunTartibiState extends State<KunTartibi> {
  DateTime _selectedDay = DateTime.now();
  int a = 0;
  List<int> indexx = [];
  late String lat;
  late String long;
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
    DatabaseHelper dataBaseHelper = DatabaseHelper.intancee;

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: size.height * 0.022, left: size.height * 0.022),
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
                  crTask(context),
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
                weekdays: const [
                  "Du",
                  "Se",
                  "Chor",
                  "Pay",
                  "Ju",
                  "Shan",
                  "Yak",
                ],
                backgroundColor: Colors.white,
                selectedDigitBackgroundColor: const Color(0xFF41966F),
                enableWeeknumberText: false,
                selectedDay: _selectedDay,
                // DateTime
                changeDay: (value) => setState(() {
                  _selectedDay = value;
                }),
              ),
            ),
            Divider(
              color: const Color(0xFFDCDCDC),
              thickness: size.height * 0.022,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Pencapaian : 75%",
                  style: TextStyle(
                      fontSize: size.height * 0.026,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Semua (8)",
                  style: TextStyle(
                      fontSize: size.height * 0.026,
                      color: const Color(0xFF41966F),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: size.width * 0.89,
              child: StepProgressIndicator(
                totalSteps: 20,
                currentStep: indexx.length,
                size: size.width * 0.04,
                padding: 0,
                selectedColor: const Color(0xffF5AC1C),
                unselectedColor: const Color(0xffC4C4C4),
                roundedEdges: Radius.circular(size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.width * 0.06,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: size.width * 0.06, left: size.width * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Shalat Shubuh",
                                  style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.grey,
                                      size: size.width * 0.042,
                                    ),
                                    Text(
                                      "12:10",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: size.width * 0.042),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.04),
                              ),
                              hoverColor: Colors.orange,
                              // fillColor: const MaterialStatePropertyAll(
                              //   Color(0xFF41966F),
                              // ),
                              checkColor: Colors.white,
                              activeColor: const Color(0xFF41966F),
                              value: indexx.contains(index) ? true : false,
                              onChanged: (value) {
                                setState(() {
                                  indexx.contains(index)
                                      ? indexx.remove(index)
                                      : indexx.add(index);
                                });
                              },
                            )
                          ],
                        ),
                        Divider(
                          thickness: size.width * 0.004,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget crTask(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  var size = mediaQueryData.size;
  return Card(
    shadowColor: Colors.black,
    elevation: size.height * 0.004,
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.circular(size.height * 0.006),
    ),
    child: InkWell(
      onTap: () {
        creatTask();
        // WidgetsBinding.instance.addPostFrameCallback(
        //   (_) {
        //     showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlderDilaogNew(context);
        //         });
        //   },
        // );
      },
      child: Container(
        alignment: Alignment.center,
        height: size.width * 0.08,
        width: size.width * 0.32,
        decoration: BoxDecoration(
          color: const Color(0xFF41966F),
          borderRadius: BorderRadius.all(
            Radius.circular(size.height * 0.006),
          ),
        ),
        child: Text("Faolyat qo'shish",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: size.width * 0.04)),
      ),
    ),
  );
}

creatTask()async{
  Task muslimTask=Task("titled", "descriptiond", "DateTime.now() as");
  var res= DatabaseHelper.intancee.insert(muslimTask);
  print("ishladi aka: $res");
}
Widget AlderDilaogNew(BuildContext context) {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  var size = MediaQuery.of(context).size;
  return BlocBuilder<MaleCubit, bool>(
    builder: (context, maleOr) {
      return AlertDialog(
        backgroundColor: Colors.white70,
        title: Container(
          padding: EdgeInsets.only(
              bottom: size.height * 0.02, top: size.height * 0.02),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: maleOr == false
                ? const Color(0xFF41966F)
                : const Color(0xFFF540EC),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(
                    color: maleOr == false
                        ? const Color(0xFF41966F)
                        : const Color(0xFFFB6CF4),
                    fontWeight: FontWeight.bold),
                cursorColor: maleOr == false
                    ? const Color(0xFF41966F)
                    : const Color(0xFFFB6CF4),
                controller: name,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelStyle: TextStyle(
                    color: maleOr == false
                        ? const Color(0xFF41966F)
                        : const Color(0xFFFB6CF4),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.height * 0.06),
                        topLeft: Radius.circular(size.height * 0.06)),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  hintText: 'Ish nomini kiriting!',
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextField(
                style: TextStyle(
                    color: maleOr == false
                        ? const Color(0xFF41966F)
                        : const Color(0xFFFB6CF4),
                    fontWeight: FontWeight.bold),
                cursorColor: maleOr == false
                    ? const Color(0xFF41966F)
                    : const Color(0xFFFB6CF4),
                controller: description,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: maleOr == false
                        ? const Color(0xFF41966F)
                        : const Color(0xFFFB6CF4),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(size.height * 0.06),
                        bottomLeft: Radius.circular(size.height * 0.06)),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  hintText: "Ish haqida ma'lumot!",
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                maleOr == false
                    ? const Color(0xFF41966F)
                    : const Color(0xFFF540EC),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              "Xo'p",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}