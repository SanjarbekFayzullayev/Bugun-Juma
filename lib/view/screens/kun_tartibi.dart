import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/view_cubit.dart';
import 'package:bugun_juma/main_view_model/data_base/sqflite_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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

  late String lat;
  late String long;
  late NamozVaqtlariListCubit _cubit;
  late ViewCubit _viewCubit;
  List<Map<String, dynamic>> _items = [];
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    _cubit = context.read<NamozVaqtlariListCubit>();
    _viewCubit = context.read<ViewCubit>();
    _cubit.updatePrayerTimes();
    _cubit.initPrefs();
    _loadItems();
    _viewCubit.getList();
    super.initState();
  }

  Future<void> _loadItems() async {
    final items = await SQLHelper().getItems();
    setState(() {
      _items = items;
    });
  }

  Future<void> createTask(String name, String description, String time) async {
    await SQLHelper.createItem(name, description, time);
    _loadItems();
    print("Ishlad");
  }

  Future<void> update(String name, String description, String time) async {
    await SQLHelper.createItem(name, description, time);
    _loadItems();
  }

  Future<void> delete(int id) async {
    await SQLHelper.deleteItem(id);
    _loadItems();
  }

  Future<void> clearData() async {
    final db = await SQLHelper.db();
    _viewCubit.taskList.clear();
    await db.delete('items');
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Scaffold(
      body: BlocBuilder<MaleCubit, bool>(
        builder: (context, maleOr) {
          return SafeArea(
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
                      InkWell(
                        onTap: () {
                          name.clear();
                          description.clear();
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white70,
                                      title: Container(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.02,
                                            top: size.height * 0.02),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: maleOr == false
                                              ? const Color(0xFF41966F)
                                              : const Color(0xFFF540EC),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  size.height *
                                                                      0.06),
                                                          topLeft:
                                                              Radius.circular(
                                                                  size.height *
                                                                      0.06)),
                                                  borderSide: const BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                hintText:
                                                    'Ish nomini kiriting!',
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
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
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  size.height *
                                                                      0.06),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  size.height *
                                                                      0.06)),
                                                  borderSide: const BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                hintText:
                                                    "Ish haqida ma'lumot!",
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                              maleOr == false
                                                  ? const Color(0xFF41966F)
                                                  : const Color(0xFFF540EC),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: const Text(
                                            "Ortga",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                              maleOr == false
                                                  ? const Color(0xFF41966F)
                                                  : const Color(0xFFF540EC),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (name.text != "" &&
                                                description.text != "") {
                                              var now = DateTime.now();
                                              createTask(
                                                  name.text,
                                                  description.text,
                                                  "${now.day}:${now.month}:${now.year}");
                                              Navigator.of(context).pop(false);
                                            }
                                          },
                                          child: const Text(
                                            "Qo'shish",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.width * 0.08,
                          width: size.width * 0.32,
                          decoration: BoxDecoration(
                            color: maleOr == false
                                ? const Color(0xFF41966F)
                                : const Color(0xFFF540EC),
                            borderRadius: BorderRadius.all(
                              Radius.circular(size.height * 0.006),
                            ),
                          ),
                          child: Text("Ish qo'shish",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.04)),
                        ),
                      )
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
                    selectedDigitBackgroundColor: maleOr == false
                        ? const Color(0xFF41966F)
                        : const Color(0xFFF540EC),
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
                      "Bajarilmagan : ${_items.length - _viewCubit.taskList.length}",
                      style: TextStyle(
                          fontSize: size.height * 0.022,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Ishlar soni (${_items.length})",
                      style: TextStyle(
                          fontSize: size.height * 0.022,
                          color: maleOr == false
                              ? const Color(0xFF41966F)
                              : const Color(0xFFF540EC),
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
                    totalSteps: _items.isEmpty ? 1 : _items.length,
                    currentStep: _viewCubit.taskList.length,
                    size: size.width * 0.03,
                    // Adjust this size as necessary
                    padding: 0.0001,
                    // Add padding if needed
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
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            right: size.width * 0.06, left: size.width * 0.06),
                        child: InkWell(
                          onTap: () {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlderTaskInfo(
                                          context, maleOr, item["description"]);
                                    });
                              },
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.56,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          item["title"].toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: Colors.grey,
                                            size: size.width * 0.042,
                                          ),
                                          Text(
                                            item["time"],
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: size.width * 0.042),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              size.width * 0.04),
                                        ),
                                        hoverColor: Colors.orange,
                                        // fillColor: const MaterialStatePropertyAll(
                                        //   Color(0xFF41966F),
                                        // ),
                                        checkColor: Colors.white,
                                        activeColor: const Color(0xFF41966F),
                                        value:
                                            _viewCubit.taskList.contains(index)
                                                ? true
                                                : false,
                                        onChanged: (value) {
                                          setState(() {
                                            if (_viewCubit.taskList
                                                .contains(index)) {
                                              _viewCubit.taskList.remove(index);
                                              _viewCubit.saveList(
                                                  _viewCubit.taskList);
                                            } else {
                                              _viewCubit.taskList.add(index);
                                              _viewCubit.saveList(
                                                  _viewCubit.taskList);
                                            }
                                          });
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _viewCubit.taskList.remove(index);
                                          _viewCubit
                                              .saveList(_viewCubit.taskList);
                                          delete(item["id"]);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Divider(
                                thickness: size.width * 0.004,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget AlderTaskInfo(BuildContext context, bool maleOr, String description) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  var size = mediaQueryData.size;
  return AlertDialog(
    backgroundColor: Colors.white70,
    title: Container(
      height: size.height * 0.5,
      padding: EdgeInsets.all(size.height * 0.02),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            maleOr == false ? const Color(0xFF41966F) : const Color(0xFFF540EC),
      ),
      child: SingleChildScrollView(
        child: Text(
          description,
        style:  TextStyle(color: Colors.white60,fontSize: size.height * 0.034),
        ),
      ),
    ),
    actions: [
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            maleOr == false ? const Color(0xFF41966F) : const Color(0xFFF540EC),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        child: const Text(
          "Ortga",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}
