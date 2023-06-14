import 'package:flutter/material.dart';

const String kIconHost = 'www.openweathermap.org';

Widget showIcon(String icon, {double? width, double? height}) {
  return FadeInImage.assetNetwork(
    placeholder: 'assets/images/loading.gif',
    image: 'http://$kIconHost/img/wn/$icon@4x.png',
    width: width ?? 96,
    height: height ?? 96,
  );
}
