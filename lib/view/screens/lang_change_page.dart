import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import 'package:bugun_juma/view/screens/bottom_naw_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanChangePage extends StatefulWidget {
  bool openIn;

  LanChangePage(this.openIn, { Key? key}) : super(key: key);

  @override
  State<LanChangePage> createState() => _LanChangePageState();
}

class _LanChangePageState extends State<LanChangePage> {
  late NamozVaqtlariListCubit _cubit;
  late int indexSelected;


  @override
  void initState() {
    _cubit = context.read<NamozVaqtlariListCubit>();
    _cubit.getCounterIndex();
    _cubit.updatePrayerTimes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Scaffold(
      body: BlocBuilder<MaleCubit, bool>(
        builder: (context, state) {
          return BlocBuilder<NamozVaqtlariListCubit, List<String>>(
            builder: (context, namozVaqtlari) {
              return ListView.builder(
                itemCount: _cubit.viloyatlar.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 8),
                    child: Card(
                      elevation: 6,
                      shadowColor: Colors.black,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: InkWell(
                        overlayColor: MaterialStateProperty.all(
                            Colors.transparent),
                        onTap: () {
                          _cubit.country(index);
                          _cubit.saveCounterIndex(index);
                          print(_cubit.longitude);

                          widget.openIn == false
                              ? Navigator.pop(context)
                              : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomNawBar(),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width * 0.82,
                          height: size.height * 0.096,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: _cubit.countIndex == index
                                ? state==false? const Color(0xFFC2E9DA):const Color(0xFFFFBCFC)
                                : Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(size.height * 0.026),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: size.height * 0.02,
                                right: size.height * 0.02),
                            child: Text(
                              _cubit.viloyatlar[index],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.height * 0.024),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
