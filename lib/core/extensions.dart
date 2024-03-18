import 'package:flutter/widgets.dart';

extension MapExtensions<K, V> on Map<K, V> {
  /// Order by keys
  Map<K, V> sortByKeys(int Function(K a, K b) compareTo) {
    return Map.fromEntries(
        entries.toList()..sort((a, b) => compareTo(a.key, b.key)));
  }

  /// Order by values
  Map<K, V> sortByValues(int Function(V a, V b) compareTo) {
    return Map.fromEntries(
        entries.toList()..sort((a, b) => compareTo(a.value, b.value)));
  }
}

extension FocusExtension on BuildContext {
  void unFocus(){
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.focusedChild?.unfocus();
    }
  }
}
