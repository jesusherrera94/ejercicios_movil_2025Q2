import 'package:intl/intl.dart';

String timestampToDatestring(int unixTimestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      unixTimestamp * 1000,
    );
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }