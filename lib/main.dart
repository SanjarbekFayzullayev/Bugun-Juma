import 'package:bugun_juma/main_view_model/cubit/hat_chop_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/index_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/name_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/tasbih_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/tasbih_total_cubit.dart';
import 'package:bugun_juma/view/screens/bottom_naw_bar.dart';
import 'package:bugun_juma/view/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_view_model/cubit/male_cubit.dart';
import 'main_view_model/cubit/view_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String username = '';
  late SharedPreferences loginData;

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString("name")!;
    });
  }

  @override
  void initState() {
    initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(providers: [
      BlocProvider<MaleCubit>(
        create: (context) => MaleCubit(),
      ),
      BlocProvider<ViewCubit>(
        create: (context) => ViewCubit(),
      ),
      BlocProvider<NameCubit>(
        create: (context) => NameCubit(),
      ),
      BlocProvider<NamozVaqtlariListCubit>(
        create: (context) => NamozVaqtlariListCubit(),
      ),
      BlocProvider<TasbihCubit>(
        create: (context) => TasbihCubit(),
      ),
      BlocProvider<TasbihTotalCubit>(
        create: (context) => TasbihTotalCubit(),
      ),
      BlocProvider<IndexCubit>(
        create: (context) => IndexCubit(),
      ),

      BlocProvider<HatChopCubit>(
        create: (context) => HatChopCubit(),
      ),

      // Add more BlocProviders as needed
    ], child: MaterialApp(

      home: BlocBuilder<MaleCubit, bool>(
        builder: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: state == false
                ? const Color(0xFF80B99F)
                : const Color(0xFFFF8CF9),
          ));
          return BlocBuilder<NameCubit, String>(

            builder: (context, state) {
              return username == '' ? LoginPage() : const BottomNawBar();
            },
          );
        },
      ),
    ),

    );
  }

}


