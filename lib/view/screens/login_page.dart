import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/name_cubit.dart';
import 'package:bugun_juma/view/screens/lang_change_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  bool openIn;

  LoginPage({this.openIn = false, Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _login = TextEditingController();
  TextEditingController _password = TextEditingController();
  late bool maleOr = false;
  late MaleCubit _cubit2;

  @override
  void initState() {
    _cubit2 = context.read<MaleCubit>();
    _cubit2.getMale();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: size.height * 0.2,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/imgs/masjidbg.png",
                            ),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topRight),
                        gradient: LinearGradient(
                          colors: maleOr == false
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
                        borderRadius: BorderRadius.only(
                          bottomRight: const Radius.circular(0),
                          bottomLeft: Radius.circular(size.height * 0.22),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      person(),
                      person2(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: Column(
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
                          controller: _login,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: maleOr == false
                                      ? const Color(0xFF41966F)
                                      : const Color(0xFFFB6CF4)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(size.height * 0.06),
                                  topLeft: Radius.circular(size.height * 0.06)),
                              borderSide: BorderSide(
                                color: maleOr == false
                                    ? const Color(0xFF41966F)
                                    : const Color(0xFFFB6CF4),
                              ),
                            ),
                            hintText: 'Ismingizni kiriting',
                            labelText: 'Ismingizni kiriting',
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                            labelStyle: TextStyle(
                              color: maleOr == false
                                  ? const Color(0xFF41966F)
                                  : const Color(0xFFFB6CF4),
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: maleOr == false
                                  ? const Color(0xFF41966F)
                                  : const Color(0xFFFB6CF4),
                            ),
                            prefixText: ' ',
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
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
                          controller: _password,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: maleOr == false
                                  ? const Color(0xFF41966F)
                                  : const Color(0xFFFB6CF4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: maleOr == false
                                    ? const Color(0xFF41966F)
                                    : const Color(0xFFFB6CF4),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight:
                                      Radius.circular(size.height * 0.06),
                                  bottomLeft:
                                      Radius.circular(size.height * 0.06)),
                              borderSide: BorderSide(
                                color: maleOr == false
                                    ? const Color(0xFF41966F)
                                    : const Color(0xFFFB6CF4),
                              ),
                            ),
                            hintText: 'Familyangizni kriting',
                            labelText: 'Familyangizni kriting',
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                            prefixIcon: Icon(
                              Icons.person,
                              color: maleOr == false
                                  ? const Color(0xFF41966F)
                                  : const Color(0xFFFB6CF4),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        InkWell(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.clear();
                            if (_password.text != "" && _login.text != "") {
                              _cubit2.setMale(maleOr);

                              context.read<NameCubit>().setName(
                                    _login.text,
                                    _password.text,
                                  );
                              widget.openIn == false
                                  // ignore: use_build_context_synchronously
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LanChangePage(true),
                                      ),
                                    )
                                  // ignore: use_build_context_synchronously
                                  : Navigator.pop(context);
                            } else {
                              var snackBar = SnackBar(
                                  backgroundColor: maleOr == false
                                      ? const Color(0xFF41966F)
                                      : const Color(0xFFFB6CF4),
                                  elevation: 12,
                                  shape: BeveledRectangleBorder(
                                    side: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(size.height * 0.22),
                                      topRight:
                                          Radius.circular(size.height * 0.22),
                                    ),
                                  ),
                                  content: const Center(
                                      child:
                                          Text("Iltimos ro'yxatdan o'ting")));
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: maleOr == false
                                  ? const Color(0xFF41966F)
                                  : const Color(0xFFFB6CF4),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Krish",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.034,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: size.height * 0.2,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage("assets/imgs/masjidbg.png"),
                            fit: BoxFit.cover),
                        gradient: LinearGradient(
                          colors: maleOr == false
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
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(size.height * 0.22),
                          topLeft: const Radius.circular(0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget person() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Card(
      elevation: size.height * 0.02,
      shadowColor: Colors.black,
      shape: BeveledRectangleBorder(
          side: BorderSide(
              color: maleOr == false ? const Color(0xFF41966F) : Colors.white),
          borderRadius: BorderRadius.circular(size.height * 0.008)),
      child: InkWell(
        onTap: () {
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(statusBarColor: Color(0xFF80B99F)),
          );
          setState(() {
            maleOr = false;
          });
        },
        child: Container(
          height: size.height * 0.08,
          width: size.width * 0.14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.008),
            image: const DecorationImage(
                image: AssetImage("assets/imgs/muslim.png"), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget person2() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Card(
      elevation: 12,
      shadowColor: Colors.black,
      shape: BeveledRectangleBorder(
          side: BorderSide(
              color: maleOr == true ? const Color(0xFFFB6CF4) : Colors.white),
          borderRadius: BorderRadius.circular(size.height * 0.008)),
      child: InkWell(
        onTap: () {
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Color(0xFFFF8CF9),
            ),
          );
          setState(() {
            maleOr = true;
          });
        },
        child: Container(
          height: size.height * 0.08,
          width: size.width * 0.14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.008),
            image: const DecorationImage(
                image: AssetImage("assets/imgs/muslima.png"),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
