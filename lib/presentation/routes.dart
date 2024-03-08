import 'package:flutter/material.dart';

class Routes {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      BuildContext context, String content) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(0),
        elevation: 0,
        content: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Center(
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Container(
              height: 90,
              width: 90,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bonic.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
