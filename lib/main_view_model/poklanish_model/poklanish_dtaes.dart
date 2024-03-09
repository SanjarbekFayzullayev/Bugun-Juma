class Tahorat {
  String name;
  String step;
  String imgUrl;

  Tahorat(
    this.step,
    this.imgUrl,
    this.name,
  );

  static List<Tahorat> data = [
    Tahorat("1. Niyat", "assets/imgs/tahorat/niyyatt.png",
        "Tahorat olish uchun , iloji bo'lsa, Qiblaga yuzlaniladi.\nAvvalo, tahorat olishga niyat qilinib, «Auzu billahi minash-shaytonir rojiym. Bismillahir rohmanir rohiym», deyiladi."),
    Tahorat("2. Qo‘l yuvish", "assets/imgs/tahorat/bir.png",
        " Qo'llar bandigacha uch marta yuviladi. Barmoqda uzuk bo'lsa, qimirlatib, ostiga suv yugurtiriladi."),
    Tahorat("3. Og'izni chaynash", "assets/imgs/tahorat/ikki.png",
        " O'ng qo'lda suv olinib, og'iz uch marta g'arg'ara qilib chayiladi va misvok qilinadi. "),
    Tahorat("4. Burunni yuving", "assets/imgs/tahorat/uch.png",
        "Burunga o'ng qo'l bilan uch marta suv tortilib, chap qo'l bilan qoqib tozalanadi."),
    Tahorat("5. Yuz uch marta yuviladi. ", "assets/imgs/tahorat/besht.png",
        "Yuzingizni uch marta yuving. Yuzning chegarasi - soch o'sadigan joydan yonoq tepasigacha bo'lgan uzunlik, kengligi esa ikki quloq bo'lagi orasidagi joy."),
    Tahorat("6. Qo'lingizni tirsakgacha yuving", "assets/imgs/tahorat/olti.png",
        "Avval o'ng qo'l tirsaklar bilan qo'shib ishqalab yuviladi."),
    Tahorat(
        "7. Qo'lingizni tirsakgacha yuving",
        "assets/imgs/tahorat/yetti.png",
        "So'ngra chap qo'l tirsaklar bilan qo'shib ishqalab yuviladi. "),
    Tahorat("8. Barmoqlar orasini yuvish", "assets/imgs/tahorat/sakkirz.png",
        "Barmoqlarni birin-ketin yuving - o'ng qo'lni uch marta, keyin chap qo'lni uch marta yuving."),
    Tahorat("9. Masx", "assets/imgs/tahorat/toqqiz.png",
        "Hovuchga suv olib, to'kib tashlab, ho'li bilan boshning hamma qismiga masx tortiladi. "),
    Tahorat("10(1). Masx", "assets/imgs/tahorat/on.png",
        " Ikkala kaftning orqasi bilan bo'yin masx qilinadi."),
    Tahorat("10(2). Masx", "assets/imgs/tahorat/onbir.png",
        "Ko'rsatkich barmoq bilan quloqlarning ichi, bosh barmoqlar bilan esa quloq orqasi masx qilinadi. "),
    Tahorat("11. Oyoqlarni yuvish", "assets/imgs/tahorat/onbesht.png",
        "Chap qo'l bilan o'ng oyoqni oshiq (to'piq) bilan qo'shib va barmoqlar orasini (ishqalab) uch marta yuviladi."),
    Tahorat("12. Oyoqlarni yuvish", "assets/imgs/tahorat/onolti.png",
        "Chap oyoq ham shu tarzda uch marta yuviladi. "),
    Tahorat("Eslatma!", "assets/imgs/masjidbg.png",
        "Tirnoqlarga surilgan lak, teridagi har xil bo'yoqlar ketkazilmasdan olingan tahorat sahih (haqiqiy) hisoblanmaydi Tahorat olayotganda gapirmaslik, ehtiyojdan ortiq suv ishlatmaslik, ust-boshga suv sachratmaslik kerak."),
    Tahorat("TAHORATNI BUZADIGAN HOLLAR", "assets/imgs/masjidbg.png", """ 
1. Badanning biror joyidan qon yoxud yiring chiqib oqishi.
2. Og'iz to'lib qusish.
3. Kichik yo katta hojat.
4. Yel chiqishi.
5. Milk qonab, tupurganda tupuk rangining qizil bo'lishi;
6. Hushdan ketish;
7. Namoz o'qiyotib, yonidagi odam eshitadigan darajada kulish."""),
  ];
}

class Gusul {
  String name;
  String step;
  String imgUrl;

  Gusul(this.step, this.name, this.imgUrl);

  static List<Gusul> dataGusul = [
    Gusul(
        "G'usul",
        "Uyquda ehtilom bo'lib qolinganida, jinsiy aloqadan keyin hamda ayollar hayz va nifos holatidan chiqishgach, g'usl (butun badanni suv bilan ishqalab yuvish) farzdir.Bundan tashqari, har juma va hayit namozlari oldidan g'usl qilish sunnat – Payg'ambarimiz sollallohu alayhi va sallam bajargan amallardandir.",
        "assets/imgs/masjidbg.png"),
    Gusul(
        "G'uslning farzlari",
        """
1. Og'izga suv olib g'arg'ara qilish.""",
        "assets/imgs/gusul/farz.png"),
    Gusul(
        "G'uslning farzlari:",
        """
2. Burunga, achishtirguncha suv tortish.
""",
        "assets/imgs/gusul/farz2.png"),
    Gusul(
        "G'uslning farzlari:",
        """
3. Butun badanni tozalab yuvish.""",
        "assets/imgs/gusul/uch.png"),
    Gusul(
        "G'usl quyidagi tartibda qilinadi:",
        """
 1. «Bismillahir rohmanir rohiym» deyiladi va g'uslga niyat qilinadi:
«Navaytu an ag'tasila g'uslan minal janabati raf'an lil hadasi va istibahatan lis-solati taqorruban minallohi ta'ala».
Ma'nosi: Nopoklikni ketkazish, namoz o'qishni joiz etish hamda Allohga yaqinlik istab g'uslni niyat qildim.
 """,
        "assets/imgs/gusul/bir.png"),
    Gusul(
        "G'usl quyidagi tartibda qilinadi:",
        """
 2. Qo'llar va barmoqlar  yaxshlab yuviladi.
 """,
        "assets/imgs/gusul/ikki.png"),
    Gusul(
        "G'usl quyidagi tartibda qilinadi:",
        """
 3.Badan maniy yoxud boshqa nopok narsalardan tozalanadi.
 """,
        "assets/imgs/gusul/uch.png"),
    Gusul(
        "G'usl quyidagi tartibda qilinadi:",
        """
 4. Belgilangan tartibda tahorat olinadi. Avval boshga, keyin o'ng va chap yelkaga suv quyilib, butun badan yaxshilab yuviladi. Bu yuvinishda badanda ignaning uchiday quruq joy qolsa ham, g'usl mukammal olinmagan hisoblanadi.
G'uslga ehtiyojmand kishi og'zi va burnini chayib, so'ng cho'milsa ham, g'usl olgan hisobiga o'tadi.
 """,
        "assets/imgs/gusul/uch.png")
  ];
}

class Tayammum {
  String name;
  String step;
  String imgUrl;

  Tayammum(this.step, this.name, this.imgUrl);

  static List<Tayammum> dataTayammum = [
    Tayammum(
        "Tayammum",
        """Alloh taolo Niso surasining 43-oyatida shunday marhamat qiladi (mazmuni): «Bordiyu betob yo safarda bo'lsangizlar yoki sizlardan birortangiz hojatxonadan chiqqan bo'lsa yoxud xotinlaringiz bilan yaqinlik qilgan bo'lsangiz-u suv topa olmasangiz, pokiza yer (tuproq, tosh, qum, chang kabilar) bilan tayammum qilib, yuzlaringiz va qo'llaringizga surting. Albatta, Alloh afv etuvchi va kechiruvchidir».
Tayammum qilishda tahoratga yoki g'uslga ham niyat qilinadi. Har ikkisini qo'shib niyat qilish ham mumkin.""",
        "assets/imgs/masjidbg.png"),
    Tayammum(
        "Tayammum olish tartibi quyidagichadir:",
        """1. Yenglarni tirsaklarigacha shimarib «Tahorat (yoki g'usl) uchun tayammum olishga niyat qildim», deb ko'ngildan o'tkaziladi.
""",
        "assets/imgs/tayammum/bir.png"),
    Tayammum(
        "Tayammum olish tartibi quyidagichadir:",
        """2. «A'uzu billahi minash-shaytonir rojiym. Bismillahir rohmanir rohiym», deyiladi va qo'llar, barmoqlari ochiq holda, tuproq yoki tuproq jinsidan bo'lgan biror narsaga bir marta uriladi.
""",
        "assets/imgs/tayammum/bir.png"),
    Tayammum(
        "Tayammum olish tartibi quyidagichadir:",
        """3. Qo'llarning ichi (kaft) bilan yuzga masx tortiladi.
""",
        "assets/imgs/tayammum/uch.png"),
    Tayammum(
        "Tayammum olish tartibi quyidagichadir:",
        """4. Qo'llarni ikkinchi bor tuproq yoki tuproq jinsidan bo'lgan narsaga urib, chap qo'lning kafti bilan o'ng qo'lga tirsagi bilan qo'shib, o'ng qo'l kafti bilan esa chap qo'lga ayni tarzda masx etiladi.
""",
        "assets/imgs/tayammum/tort.png"),
    Tayammum(
        "Tayammumni buzadigan hollar:",
        """1. Tahoratga yaroqli suv topishi.
2. Badandagi yara yoki (boshqa) uzr tufayli tayammum olgan kishidan bu holatlarning ketishi.
3. Tahoratni buzadigan hollar tayammumni ham buzadi.""",
        "assets/imgs/masjidbg.png")
  ];
}
