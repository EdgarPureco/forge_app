import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuccesDialog {
  static AwesomeDialog msgDialog({
    required BuildContext context,
    DialogType dgt = DialogType.success,
    required String texto,
    required Function() onPress,
  }) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: dgt,
      body: Center(
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: '',
      desc: '',
      btnOkOnPress: onPress,
    );
  }

  static AwesomeDialog msgDialogCOpt({
    required BuildContext context,
    DialogType dgt = DialogType.success,
    required String texto,
    String onOkText = 'si',
    required Function() onOkPress,
    String onCancelText = 'Cancelar',
    required Function() onCancelPress,
  }) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: dgt,
      body: Center(
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: '',
      desc: '',
      btnOkText: onOkText,
      btnOkOnPress: onOkPress,
      btnCancelText: onCancelText,
      btnCancelOnPress: onCancelPress,
    );
  }
}

class ErrorDialog {
  static AwesomeDialog msgDialog({
    required BuildContext context,
    DialogType dgt = DialogType.error,
    required String texto,
    required Function() onPress,
  }) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: dgt,
      body: Center(
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: '',
      desc: '',
      btnOkOnPress: onPress,
    );
  }

  static AwesomeDialog msgDialogCOpt({
    required BuildContext context,
    DialogType dgt = DialogType.error,
    required String texto,
    String onOkText = 'Si',
    required Function() onOkPress,
    String onCancelText = 'Cancelar',
    required Function() onCancelPress,
  }) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: dgt,
      body: Center(
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: '',
      desc: '',
      btnOkText: onOkText,
      btnOkOnPress: onOkPress,
      btnCancelText: onCancelText,
      btnCancelOnPress: onCancelPress,
    );
  }
}

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static showSnackBar(
      {required String message, required int type,  Color color = const Color.fromARGB(255, 91, 91, 91)}) {
    final Widget icono;
    switch (type) {
      case 1:
        icono = const Icon(Icons.check, color: Colors.green);
        break;
      case 2:
        icono = const Icon(Icons.wifi_off_outlined, color: Colors.yellow);
        break;
      default:
        icono = const Icon(Icons.error_outline, color: Colors.red);
    }
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icono,
          const SizedBox(width: 20),
          Expanded(
              child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ))
        ],
      ),
      backgroundColor: color,
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

/** * * toasMessage * - Muestra un mensaje de toast * @param msg : texto del mensaje * @param time : tiempo de duracion * @param delay : tiempo delay en lanzar el mensaje */ static toasMessage(
      {required String msg, int time = 5, int delay = 1}) {
    Future.delayed(Duration(seconds: delay), () {
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        webBgColor: "#e74c3c",
        textColor: Colors.black,
        timeInSecForIosWeb: time,
      );
    });
  }
}
