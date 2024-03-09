import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main_view_model/cubit/male_cubit.dart';

class BannerLogo extends StatelessWidget {
  IconData url;
  String name;

  BannerLogo(this.url, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: size.height * 0.09,
              height: size.height * 0.09,
              decoration: BoxDecoration(
                border: Border.all(
                    color: state == false
                        ? const Color(0xFF52BF95)
                        : const Color(0xFFFB6CF4),
                    width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
              ),
              child: Icon(url,
                  color: state == false
                      ? const Color(0xFF52BF95)
                      : const Color(0xFFFB6CF4),
                  size: size.height * 0.072),
            ),
            Text(
              name,
              style: TextStyle(fontSize: size.width * 0.038),
            ),
          ],
        );
      },
    );
  }
}

class AudioBannerLogo extends StatelessWidget {
  String url;
  IconData icon;

  AudioBannerLogo(this.url, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return Container(
          width: size.height * 0.09,
          height: size.height * 0.09,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(url), fit: BoxFit.cover),
            border: Border.all(
                color: state == false
                    ? const Color(0xFF52BF95)
                    : const Color(0xFFFB6CF4),
                width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
          ),
          child: Center(
            child: Icon(
              icon,
              color: state == false
                  ? const Color(0x9152BF95)
                  : const Color(0x91FB6CF4),
              size: size.height * 0.06,
            ),
          ),
        );
      },
    );
  }
}

class BannerLogoAlder extends StatelessWidget {
  IconData url;
  String name;

  BannerLogoAlder(this.url, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return BlocBuilder<MaleCubit, bool>(
      builder: (context, state) {
        return Container(
          width: size.height * 0.11,
          height: size.height * 0.11,
          decoration: BoxDecoration(
            border: Border.all(
                color: state == false
                    ? const Color(0xFF52BF95)
                    : const Color(0xFFFB6CF4),
                width: size.height * 0.004),
            borderRadius: BorderRadius.all(
              Radius.circular(size.height * 0.02),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Icon(url,
                  color: state == false
                      ? const Color(0xFF52BF95)
                      : const Color(0xFFFB6CF4),
                  size: size.height * 0.072),
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  name,
                  style: TextStyle(fontSize: size.height * 0.013),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
