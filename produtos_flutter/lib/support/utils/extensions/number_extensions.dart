import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  String get toBRL {
    if (this == 0) return 'Grátis';

    return NumberFormat.simpleCurrency(
      locale: 'pt_BR',
      decimalDigits: 2,
    ).format(this);
  }
}
