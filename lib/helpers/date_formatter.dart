import 'package:intl/intl.dart';

class DateFormatter {
  String formatDate(DateTime date) {
    String dateDay = date.day.toString();
    String dateWithSufix = '$dateDay${getOrdinalSuffix(date.day)}';

    String formattedData = DateFormat('EEEE, MMMM').format(date);

    return '$formattedData '
        ' $dateWithSufix';
  }

  String getOrdinalSuffix(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }

    var modNumber = number % 10;

    switch (modNumber) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
