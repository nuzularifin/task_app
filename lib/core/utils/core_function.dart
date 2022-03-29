import 'package:intl/intl.dart';

class CoreFunction {
  String showDateName(DateTime dateTime) {
    print('showDateName ======> $dateTime.toString()');
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
