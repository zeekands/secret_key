import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secret_key/logic.dart';

class Atbash extends StatefulWidget {
  const Atbash({Key? key}) : super(key: key);

  @override
  _AtbashState createState() => _AtbashState();
}

class _AtbashState extends State<Atbash> {
  var idSelected = 0;
  var colorSelected = Colors.black;
  final formKey = GlobalKey<FormState>();
  TextEditingController input = TextEditingController();
  TextEditingController key = TextEditingController();
  var result = "";

  @override
  Widget build(BuildContext context) {
    final chipBarList = <ItemChipBar>[
      ItemChipBar(
        0,
        'Descryption',
        deskripsiWidget(
          deskripsi: deskripsi[0],
        ),
      ),
      ItemChipBar(
        1,
        'Simulation',
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 34.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 23.r, right: 23.r),
                child: TextFormField(
                  controller: input,
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      hintText: 'Input'),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => setState(() {
                  var atbash = AtbashLogic();
                  result = atbash.encrypt(input.text);
                }),
                child: Padding(
                  padding: EdgeInsets.only(left: 23.r, right: 23),
                  child: Container(
                    height: 56.h,
                    width: 330.w,
                    child: Center(
                      child: Text(
                        "Encrypt",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              GestureDetector(
                onTap: () => setState(() {
                  var atbash = AtbashLogic();
                  result = atbash.decrypt(input.text);
                }),
                child: Padding(
                  padding: EdgeInsets.only(left: 23.r, right: 23.r),
                  child: Container(
                    height: 56.h,
                    width: 330.w,
                    child: Center(
                      child: Text("Decrypt",
                          style: GoogleFonts.poppins(color: Colors.white)),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.red),
                  ),
                ),
              ),
              SizedBox(
                height: 34.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 22.w),
                child: Text("Result",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 11.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 22.w),
                child: Text(
                  result,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    Widget currentTab() {
      return chipBarList[idSelected].bodyWidget;
    }

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MaterialApp(
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 51.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back)),
                  Padding(
                    padding: EdgeInsets.only(left: 21.w),
                    child: Text(
                      "Atbash Chiper",
                      style: GoogleFonts.poppins(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14.h,
              ),
              Material(
                elevation: 5,
                borderRadius: BorderRadiusDirectional.circular(36.r),
                child: Container(
                    width: 375.w,
                    height: 690.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(36.r),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: chipBarList
                              .map(
                                (item) => Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.h, right: 10.w),
                                  child: ChoiceChip(
                                    selectedColor: Colors.green,
                                    selectedShadowColor: Colors.white,
                                    label: SizedBox(
                                      width: 114.w,
                                      height: 40.h,
                                      child: Center(
                                        child: Text(
                                          item.title,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: colorSelected,
                                          ),
                                        ),
                                      ),
                                    ),
                                    selected: idSelected == item.id,
                                    onSelected: (_) => setState(() {
                                      idSelected = item.id;
                                      colorSelected =
                                          colorSelected == Colors.black
                                              ? Colors.white
                                              : Colors.black;
                                    }),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        Expanded(
                          child: currentTab(),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemChipBar {
  final int id;
  final String title;
  final Widget bodyWidget;

  ItemChipBar(this.id, this.title, this.bodyWidget);
}

class deskripsiWidget extends StatelessWidget {
  final String deskripsi;
  const deskripsiWidget({
    Key? key,
    required this.deskripsi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 34.w, left: 21.w, right: 21.w),
      child: Text(
        deskripsi,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

final deskripsi = [
  "Atbash cipher (also called mirror cipher or backwards alphabet or reverse alphabet) is the name given to a monoalphabetical substitution cipher which owes its name and origins to the Hebrew alphabet. How to encrypt using Atbash cipher Atbash encryption uses a substitution alphabet and its reciprocal, a combination of the normal alphabet and its reverse alphabet (mirrored). Example: The latin alphabet ABCDEFGHIJKLMNOPQRSTUVWXYZ and its reverse: ZYXWVUTSRQPONMLKJIHGFEDCBA are combine in the substitution table:"
];
