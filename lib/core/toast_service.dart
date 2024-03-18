import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

abstract final class ToastService {
  static void showSuccess(String message) {
    BotToast.showNotification(
      title: (cancelFunc) => Text(message),
      borderRadius: 8.0,
      align: Alignment.bottomCenter
    );
  }
}
