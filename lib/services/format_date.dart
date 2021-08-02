import 'package:intl/intl.dart';

String formateDate(inputDate) {
  final input = new DateFormat('yyyy-MM-dd');
  final output = new DateFormat('dd-MM-yyyy');
  final date = input.parse(inputDate.toString().split("T")[0]);
  final finalDate = output.format(date);
  return finalDate;
}
