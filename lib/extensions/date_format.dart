import 'package:intl/intl.dart';

extension FormattedDate on DateTime {
  String toMMMdyyyy() {
    return DateFormat('MMM d, yyyy').format(this);
  }
}
