import 'package:intl/intl.dart' as format;

extension DateFormat on DateTime {
  String toSlashDDMMYY() {
    return format.DateFormat('dd/MM/yyyy').format(
      this,
    );
  }
}

extension DateFormatString on String {
  // String toSlashDDMMYY() {
  //   return DateTime.parse(this).toSlashDDMMYY();
  // }

  String todm() {
    return format.DateFormat('dd MMMM').format(DateTime.parse(this));
  }
}
