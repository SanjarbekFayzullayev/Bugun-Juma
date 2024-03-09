import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/namoz_model/namoz.dart';
import 'package:bugun_juma/view/screens/namoz_page/namoz_page_detalis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class NamozPage extends StatelessWidget {
  const NamozPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: state == false
                  ? const Color(0xFF63A988)
                  : const Color(0xFFF540EC),
            ),
            title: Text(
              state == false ? "Juma kuni (erkaklar)" : "Juma kuni (ayollar)",
              style: TextStyle(
                  color: state == false
                      ? const Color(0xFF63A988)
                      : const Color(0xFFF540EC),
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.03),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(size.height * 0.01),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.86,
                crossAxisSpacing: size.height * 0.009,
                mainAxisSpacing: size.height * 0.009,
              ),
              itemCount: Namoz.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 8,
                  color: Colors.black,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      var snackBar = SnackBar(
                        backgroundColor: state == false
                            ? const Color(0xFF41966F)
                            : const Color(0xFFFB6CF4),
                        elevation: 12,
                        shape: BeveledRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(size.height * 0.22),
                            topRight: Radius.circular(size.height * 0.22),
                          ),
                        ),
                        content: const Center(
                          child: Text("Bu bo'lim faqat erkaklar uchun"),
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      state == true && index == 3
                          ? ScaffoldMessenger.of(context).showSnackBar(snackBar)
                          : Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => NamozPageDetils(
                                    Namoz.data[index].imgUrl,
                                    Namoz.data[index].step,
                                    Namoz.data[index].name,
                                    Namoz.data[index].name),
                              ),
                            );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FlutterIslamicIcons.crescentMoon,
                            color: Colors.white,
                            size: 80,
                          ),
                          Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              Namoz.data[index].step,
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
