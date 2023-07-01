import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Overlay Demo'),
        ),
        body: const Center(
          child: OverlayButton(),
        ),
      ),
    );
  }
}

class OverlayButton extends StatefulWidget {
  const OverlayButton({Key? key}) : super(key: key);

  @override
  _OverlayButtonState createState() => _OverlayButtonState();
}

class _OverlayButtonState extends State<OverlayButton> {
  OverlayEntry? currentOverlayEntry;
  OverlayEntry? currentOverlayEntry1;
  OverlayEntry? currentOverlayEntry2;
  Timer? timer;
  Timer? timer1;
  Timer? timer2;

  @override
  void dispose() {
    timer?.cancel();
    timer1?.cancel();
    timer2?.cancel();
    super.dispose();
  }

  void showOverlay(BuildContext context, {required IconData icon, required Color color, required String message, required String additionalMessage, required int duration, required OverlayEntry? overlayEntry, required Timer? timerInstance}) {
    overlayEntry?.remove();

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 130,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Icon(icon, color: Colors.white, size: 36.0),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Text(
                        additionalMessage,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    timerInstance?.cancel();

    timerInstance = Timer(Duration(seconds: duration), () {
      overlayEntry?.remove();
      overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text('Show Overlay'),
          onPressed: () => showOverlay(context, icon: Icons.check, color: Colors.green, message: 'Well done!', additionalMessage: 'You successfully read this important message.', duration: 3, overlayEntry: currentOverlayEntry, timerInstance: timer),
        ),
        ElevatedButton(
          child: const Text('Show Overlay 1'),
          onPressed: () => showOverlay(context, icon: Icons.error, color: Colors.red, message: 'Oh Snap!', additionalMessage: 'Change a few things up and try submitting again.', duration: 3, overlayEntry: currentOverlayEntry1, timerInstance: timer1),
        ),
        ElevatedButton(
          child: const Text('Show Overlay 2'),
          onPressed: () => showOverlay(context, icon: Icons.warning, color: Colors.orange, message: 'Warning!', additionalMessage: 'Sorry! There was a problem with your request.', duration: 3, overlayEntry: currentOverlayEntry2, timerInstance: timer2),
        ),
      ],
    );
  }
}
