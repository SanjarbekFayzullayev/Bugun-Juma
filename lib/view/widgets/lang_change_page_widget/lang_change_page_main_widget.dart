import 'package:bugun_juma/view/screens/lang_change_page.dart';
import 'package:flutter/material.dart';

class LangChangeMainWidget extends StatelessWidget {
  Widget page;
  String name;
  String hintName;

  LangChangeMainWidget(this.page, this.name,this.hintName,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Padding(
      padding:  EdgeInsets.only(left: size.height*0.04, right:size.height*0.04, bottom: size.height*0.04),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black,
        shape:  BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(size.height*0.02),
          ),
        ),
        child: InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );
          },
          child: Container(
            width: size.width * 0.82,
            height: size.height * 0.096,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(size.height * 0.026),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.height * 0.02, right: size.height * 0.02),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                              color: Colors.black, fontSize: size.height * 0.024),
                        ),
                      ),
                      Text(
                        hintName,
                        style: TextStyle(
                            color: Colors.grey, fontSize: size.height * 0.022),
                      ),
                    ],
                  ),
                  Expanded(child: Icon(Icons.arrow_forward_ios,size: size.height * 0.04,color: Colors.black))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
