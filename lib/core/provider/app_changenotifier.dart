import 'package:flutter/material.dart';

/// Notifier class to fix issue where sometimes the notify listener still called when notifier is disposed
class AppChangeNotifier extends ChangeNotifier {
  bool _isDisposed = false;

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}
