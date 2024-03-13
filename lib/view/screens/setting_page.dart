import 'package:bugun_juma/main_view_model/cubit/name_cubit.dart';
import 'package:bugun_juma/view/screens/lang_change_page.dart';
import 'package:bugun_juma/view/screens/login_page.dart';
import 'package:bugun_juma/view/screens/namoz_page/namoz_page_detalis.dart';
import 'package:bugun_juma/view/widgets/lang_change_page_widget/lang_change_page_main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main_view_model/cubit/namoz_vaqtlari_cubit.dart';

class SettingPage extends StatefulWidget {
  bool openIn;

  SettingPage({this.openIn = false, Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late NamozVaqtlariListCubit _cubit;
  late NameCubit _cubit2;
  late int indexSelected;

  @override
  void initState() {
    _cubit = context.read<NamozVaqtlariListCubit>();
    _cubit.getCounterIndex();
    _cubit2 = context.read<NameCubit>();
    _cubit.updatePrayerTimes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<NamozVaqtlariListCubit, List<String>>(
        builder: (context, namozVaqtlari) {
          return BlocBuilder<NameCubit, String>(
            builder: (context, stateName) {
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LangChangeMainWidget(
                        LanChangePage(widget.openIn),
                        "📍 Joylashuvni o'zgartrish",
                        _cubit.viloyatlar[_cubit.countIndex]),
                    LangChangeMainWidget(LoginPage(openIn: true),
                        "👤 Ma'lumotlarni o'zgartrish", stateName),
                    LangChangeMainWidget(
                        NamozPageDetils(
                            "assets/imgs/masjidbg.png",
                            "Dastur haqida",
                            """Assalomu alaykum va rahmatullohi va barokotuh $stateName!
 \nAvvalom bor ushbu ilovadan foydalnayotganizngiz uchun biz sizdan juda minaddormiz .Alloh ilohim ma'nifaatli qilsin.🤲

Dastur qulayliklari: 
\n
🔰 Poklansh
Bu bo'lim yordamida siz Taxorat, G'usul,Tayammum olishni o'rganishingiz mumkin (rasimlar bilan).  
🔰 Juma kuni
Bu bo'lim yordamida siz Juma kuni qilish kerak bo'lgan amallar hususan Juma namoz(Erkaklar uchun), Juma kuni fazilatlari haqida bilib olasiz.
🔰 Tsbeh              
Bu funksiya yordamida siz kundalik zikirlaringizni qilishingiz hamda ularni  sonini hisoblashingiz mumkin.
🔰 Qu'ron
Bu bo'limda siz "Qur'oni karim"  qiroatini Islom dunyosidagi buyuk olimlar ijrosida tinglashingiz mumkin.   
🔰 Hat cho'p
Bu funksiya yordamida siz ohirgi eshitilgan "Qur'oni karim" qiroatini qiyinchiliksiz topishingiz mumkin.
🔰 Hikmatlar
Bu funksiya yordamida siz Islom dunyosida katta iz qoldirgan olimlarning maslahatlarini o'qib ibrat olishingiz mumkin.
🔰 Namoz vaqtlari
Ushbu bo'limda  siz O'zbekiston Respublikasi dagi barcha viloyatlardagi Namoz vaqtlarini bilishingiz mumkin(Uchbu funksiya test holatda ishlamoqda).
🔰 Qiblani toping
Bu funksiya yordamida siz Qiblani topishingiz mumkin. Eslatib o'tamiz (Ushbu funksiya test holatda ishlamoqda).
🔰 Muslim(a) kun tartibi 
Bu bo'limda siz o'z kiningizni tartiblab olishingiz mumkin(Alloh izni ila).

Bazi bir manbalar Ziyouz.com saytidan olindi!

Ushbu ilovani "MuslimSoft LLC" jamoasi Allohning izni ila siz azizlar uchun ❤ bilan tayyorladi. 
Ilovadan kamchiliklar topsangiz bizdan.Foyda topsangiz Allohdandir.Ilova ichida kamchiliklar topsangiz oldindan uzur so'raymiz
Iltimos bizning haqimizga duo qiling. 
Assalomu alaykum va rahmatullohi va barokotuh!
                    """,
                            "Dastur haqida",
                            setting: true),
                        "📖 Dastur xaqida",
                        "Ma'lumotlar"),
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
