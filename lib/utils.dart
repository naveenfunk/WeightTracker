import 'package:intl/intl.dart';

class Utils {
  static String getFormattedDate(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("dd MMMM yy 'at' HH:mm");
    return dateFormat.format(dateTime);
  }

  static DateTime getDateFromString(String dateTime) {
    DateFormat dateFormat = DateFormat("dd MMMM yy 'at' HH:mm");
    return dateFormat.parse(dateTime);
  }
}
