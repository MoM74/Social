import 'package:flutter/material.dart';
import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';


//dcd6f7
const kTextColor = Color(0xFFdcd6f7);
const kPrimaryColor = Color(0xff4506a7);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kHourColor = Color(0xFFF5C35A);
const kCardColor = Color(0xFF282B30);
const kBGColor = Color(0xFF343537);
const kCalendarDay = TextStyle(
  color: kTextColor,
  fontSize: 16.0,
);

const secondaryColor = Color(0xFFe61c5d);
const contentColorLightTheme = Color(0xFF1D1D35);
const contentColorDarkTheme = Color(0xFFF5FCF9);
const warninngColor = Color(0xFFF3BB1C);
const errorColor = Color(0xFFF03738);
const defaultPadding = 14.0;
final List<String> demoContactsImage =
List.generate(5, (index) => "assets/images/user_${index + 1}.png");

void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    if (value)
    {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
String uId = '';
