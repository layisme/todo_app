import 'package:flutter/material.dart';
import 'package:todo_app/src/presentation/_widget/loading/base_loading_widget.dart';

class LoadingPopup {
  static Future<void> showLoading(BuildContext context) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context, animation, secondaryAnimation) =>  PopScope(
        canPop: false,
        child: Center(
          child: SizedBox(
            width: 120,
              height: 120,
            child: Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseLoading(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Please wait...')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
