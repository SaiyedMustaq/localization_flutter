import 'package:flutter/material.dart';

import 'localization_app.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context).getConvertedValue(key)!;
}
