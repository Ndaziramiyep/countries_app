import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Create a simple globe icon
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final size = 1024.0;
  
  // Background
  final bgPaint = Paint()..color = const Color(0xFF2196F3);
  canvas.drawRect(Rect.fromLTWH(0, 0, size, size), bgPaint);
  
  // Globe circle
  final globePaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 40;
  canvas.drawCircle(Offset(size / 2, size / 2), size / 3, globePaint);
  
  // Horizontal lines
  for (var i = 1; i <= 3; i++) {
    final y = size / 4 * i;
    canvas.drawLine(
      Offset(size / 2 - size / 3, y),
      Offset(size / 2 + size / 3, y),
      globePaint,
    );
  }
  
  // Vertical line
  canvas.drawLine(
    Offset(size / 2, size / 2 - size / 3),
    Offset(size / 2, size / 2 + size / 3),
    globePaint,
  );
  
  final picture = recorder.endRecording();
  final img = await picture.toImage(size.toInt(), size.toInt());
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  
  final file = File('assets/icon/icon.png');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData!.buffer.asUint8List());
  
  print('Icon generated successfully at: assets/icon/icon.png');
  exit(0);
}
