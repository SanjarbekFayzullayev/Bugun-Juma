import 'package:bugun_juma/main_view_model/cubit/male_cubit.dart';
import 'package:bugun_juma/main_view_model/cubit/view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PoklanishPage extends StatefulWidget {
  List data;
  String name;

  PoklanishPage(this.data, this.name, {Key? key}) : super(key: key);

  @override
  State<PoklanishPage> createState() => _PoklanishPageState();
}

class _PoklanishPageState extends State<PoklanishPage> {
  late ViewCubit cubit = context.read<ViewCubit>();
@override
  void initState() {
  cubit.getView();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;

    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return BlocBuilder<ViewCubit, int>(
          builder: (context, view) {
            return Scaffold(
              backgroundColor: state == false
                  ? const Color(0xFF80B99F)
                  : const Color(0xFFFF8CF9),
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(
                          () {
                            if (view < 30 && view - 2 < 28) {
                              view++;
                            }
                          },
                        );
                        cubit.setView(view);
                        print(view);
                      },
                      icon: const Icon(Icons.zoom_in)),
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          if (view > 20 && view - 2 > 18) {
                            view--;
                          }
                        },
                      );
                      cubit.setView(view);
                    },
                    icon: const Icon(Icons.zoom_out),
                  ),
                ],
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  widget.name,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              body: ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: Material(
                      borderRadius: BorderRadius.circular(size.height * 0.04),
                      shadowColor: Colors.black,
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.height * 0.04),
                            color: const Color(0xFFE5DFEC)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(size.height * 0.01),
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  widget.data[index].step.toString(),
                                  style: TextStyle(
                                      color: state == false
                                          ? const Color(0xFF63A988)
                                          : const Color(0xFFF540EC),
                                      fontWeight: FontWeight.bold,
                                      fontSize: view.toDouble()),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.data[index].name.toString(),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: view - 2.toDouble()),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: size.height * 0.0,left: size.height * 0.03,bottom: size.height * 0.01),
                                child: Image.asset(widget.data[index].imgUrl),
                              )
                            ]),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
