import 'package:intl/intl.dart';

extension IntExtension on int {
  String toNumberFormat({String format = '###,###'}) {
    return NumberFormat(format).format(this);
  }
}
