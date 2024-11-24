import 'package:flutter/material.dart';

// colors

const bgColor = Color.fromARGB(255, 255, 255, 255);
const white = Color.fromARGB(208, 255, 255, 255);
const button = Color.fromARGB(115, 222, 43, 43);
const bgdark = Color.fromARGB(255, 0, 0, 0);
const slideColor = Color.fromARGB(255, 214, 93, 82);
const lightBlue = Color.fromARGB(255, 0, 106, 255);





// font styls

const bold = "bold";
const regular = "regular";


customfontStyle({family = "bold",double? size = 14, fColor = white}){
 return  TextStyle(
          fontSize: size,
          color: fColor,
          fontFamily: family,
        );
}
 