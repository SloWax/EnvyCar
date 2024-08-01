extension StringExtension on String {
  int toInt() {
    return int.tryParse(this) ?? 0;
  }
}
