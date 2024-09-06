import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/src/core/style/style.dart';

class PopupDialog {

  static Future<bool?> showSuccess(BuildContext context,
      {String content = 'Message.OperationSuccess',
      int? layerContext,
      dynamic data,
      bool pushToLogin = false,
      bool exitApp = false,
      bool dismiss = false,
      Function()? onPop}) async {
    var result = await showDialog(
        barrierDismissible: dismiss,
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: const EdgeInsets.only(top: 15, bottom: 10),
              titlePadding: const EdgeInsets.all(0),
              content: Container(
                constraints:
                    const BoxConstraints(maxWidth: 300, maxHeight: 350),
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Information',
                        style: GoogleFonts.lato(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: Lottie.asset('assets/lottie/success.json',
                          repeat: false),
                    ),
                    Text(
                      content,
                      style: GoogleFonts.lato(),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Colors.white,
                        splashFactory: InkRipple.splashFactory,
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: Text(
                        'Accept',
                        style: GoogleFonts.lato(
                          color: Style.primaryButton,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
    // }
    return result;
  }

  static Future<bool?> showFailed(BuildContext context,
      {String? content,
      int? layerContext,
      dynamic data,
      bool pushToLogin = false,
      bool exitApp = false,
      bool dismiss = false,
      Function()? onPop}) async {
    var result = await showDialog(
        barrierDismissible: dismiss,
        context: context,
        builder: (_) => Dialog(
              elevation: 10,
              insetPadding: const EdgeInsets.all(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 300, maxHeight: 300),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Information',
                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: Lottie.asset('assets/lottie/error.json',
                          repeat: false),
                    ),
                    Text(
                      content ?? 'Operation Failed',
                      style: GoogleFonts.lato(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Colors.white,
                        splashFactory: InkRipple.splashFactory,
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: Text(
                        'Accept',
                        style: GoogleFonts.lato(
                          color: Style.primaryButton,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));

    return result;
  }

  static Widget noResult() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.grey.shade700,
          ),
          Text(
            'No data',
            style: GoogleFonts.lato(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool> yesNoPrompt(BuildContext context,
      {String? content}) async {
    // Extension.clearFocus(context);
    var result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.only(top: 15, bottom: 10),
        titlePadding: const EdgeInsets.all(0),
        content: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Confirmation',
                style: GoogleFonts.lato(),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 70,
                height: 70,
                child:
                    Lottie.asset('assets/lottie/warning.json', repeat: false),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                content ?? 'Are you sure?',
                style: GoogleFonts.lato(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(false);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      backgroundColor: Colors.grey.shade400,
                      splashFactory: InkRipple.splashFactory,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      backgroundColor: Style.primaryButton,
                      splashFactory: InkRipple.splashFactory,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                    ),
                    child: Text(
                      'Accept',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    result ??= false;
    return result;
  }

  //Photo Dialog

  //Dialog
}
