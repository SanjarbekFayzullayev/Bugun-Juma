import 'dart:math';

import 'package:bugun_juma/main_view_model/cubit/namoz_vaqtlari_cubit.dart';
import 'package:bugun_juma/main_view_model/islamic_quotes/islamic_quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main_view_model/cubit/male_cubit.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int randomNumber = random.nextInt(IslamicQuotes.quotesData.length);
    print(randomNumber);
    print(IslamicQuotes.quotesData.length);

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;

    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return Card(
          shadowColor: Colors.black,
          elevation: size.height * 0.008,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(size.height * 0.04),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            width: size.width * 0.86,
            height: size.height * 0.26,
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
            child: InkWell(
              onTap: () async {
                var snackBar = SnackBar(
                  backgroundColor: state == false
                      ? const Color(0xFF63A988)
                      : const Color(0xFFFB6CF4),
                  duration: const Duration(seconds: 1),
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.01,
                      right: size.height * 0.04,
                      left: size.height * 0.04),
                  elevation: size.height * 0.04,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.white, width: size.width * 0.01),
                    borderRadius: BorderRadius.circular(size.width * 0.04),
                  ),
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    "Matn nushalandi!",
                    style: TextStyle(
                        color: Colors.white, fontSize: size.height * 0.02),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // ignore: prefer_const_constructors
                await Clipboard.setData(
                  ClipboardData(
                      text:
                          "${IslamicQuotes.quotesData[randomNumber].description} \n\n${IslamicQuotes.quotesData[randomNumber].auth}\n\n"),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.018),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        IslamicQuotes.quotesData[randomNumber].description
                            .toString(),
                        style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontStyle: FontStyle.normal),
                      ),
                      Text(
                        IslamicQuotes.quotesData[randomNumber].auth.toString(),
                        style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
