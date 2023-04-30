class NumberHelper {
  static String shortenedDouble(double number) {
    String numb = number.toString();
    if (numb.endsWith(".0")) {
      return numb.split(".")[0];
    }
    return numb;
  }
}
