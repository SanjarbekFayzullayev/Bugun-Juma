import 'package:bugun_juma/main_view_model/namoz_model/namoz.dart';
import 'package:bugun_juma/main_view_model/poklanish_model/poklanish_dtaes.dart';
import 'package:bugun_juma/view/screens/namoz_page/namoz_page.dart';
import 'package:bugun_juma/view/screens/poklanish_page/poklanish_page.dart';
import 'package:bugun_juma/view/screens/quran_page.dart';
import 'package:bugun_juma/view/screens/tasbih.dart';
import 'package:bugun_juma/view/widgets/home_page/banner_logo.dart';
import 'package:bugun_juma/view/widgets/home_page/hat_chop.dart';
import 'package:bugun_juma/view/widgets/home_page/quotes_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class MainWidget extends StatelessWidget {
  String time;
  String joylashuv;
  dynamic cubit;
  dynamic namozName;

  MainWidget(this.time, this.joylashuv, this.cubit,this.namozName,{Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.height * 0.044)),
          shadowColor: Colors.black,
          elevation: size.width * 0.01,
          child: Container(
            width: size.width * 0.86,
            height: size.height * 0.28,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(size.height * 0.044),
                ),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: const Color(0xFFF8C45D),
                              size: size.width * 0.04,
                            ),
                            Text(
                              "$namozName namozi",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: size.width * 0.04),
                            )
                          ],
                        ),
                        Text(
                          time,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.042),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: const Color(0xFFF8C45D),
                              size: size.width * 0.04,
                            ),
                            Text(
                              "Joylashuv",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: size.width * 0.04),
                            )
                          ],
                        ),
                        Text(
                          joylashuv,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.042),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  height: size.width * 0.002,
                  endIndent: size.width * 0.06,
                  indent: size.width * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlderDilaogNew(context);
                                });
                          },
                        );
                      },
                      child: BannerLogo(FlutterIslamicIcons.wudhu, "Poklanish"),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>  const NamozPage(),
                          ),
                        );
                      },
                      child: BannerLogo(FlutterIslamicIcons.ramadan, "Juma kuni"),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>  const TasbihPage(),
                          ),
                        );
                      },
                      child: BannerLogo(FlutterIslamicIcons.tasbih, "Tasbeh"),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>  const QuranPage(),
                          ),
                        );
                      },
                      child: BannerLogo(FlutterIslamicIcons.quran2, "Qu'ron"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const HatChopWidget(),
        const QuotesPage(),
      ],
    );
  }

  Widget AlderDilaogNew(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: Colors.white70,
      content: Container(
        alignment: Alignment.center,
        height: size.height * 0.120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>  PoklanishPage(Tahorat.data,"Tahorat olish"),
                  ),
                );
              },
              child: BannerLogoAlder(Icons.water_drop_outlined, "Tahorat"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PoklanishPage(Gusul.dataGusul,"G'usul qilish"),
                  ),
                );
              },
              child: Padding(
                padding:  EdgeInsets.only(left: size.height*0.002,right: size.height*0.002),
                child: BannerLogoAlder(Icons.shower_outlined, "G'usul"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PoklanishPage(Tayammum.dataTayammum,"Tayammum qilish"),
                  ),
                );
              },
              child: BannerLogoAlder(Icons.sign_language_outlined, "Tayammum"),
            ),
          ],
        ),
      ),
    );
  }
}
