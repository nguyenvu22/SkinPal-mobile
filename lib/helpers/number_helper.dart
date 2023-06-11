import 'package:intl/intl.dart';

class NumberHelper {
  static String shortenedDouble(double number) {
    String numb = number.toString();
    if (numb.endsWith(".0")) {
      return numb.split(".")[0];
    }
    return numb;
  }

  static String convertToVietNameCurrency(double money) {
    int roundedMoney = money.round().toInt();
    String formattedMoney = NumberFormat('#,###', 'en_US').format(roundedMoney);
    return formattedMoney;
  }
}
