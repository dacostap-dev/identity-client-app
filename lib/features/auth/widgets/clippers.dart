//CustomClipperestá restringiendo el área de pintura, mientras CustomPainter da un lienzo para pintar libremente.
import 'package:flutter/material.dart';

class MyClipperOne extends CustomClipper<Path> {
  final double animationValue;

  MyClipperOne(this.animationValue);

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height - 50;

    //Lerp es util para interpolar entre dos valores en base a un valor de 0-1, como una animacion (en este caso da igual porq el offset dy es de 0 a 1 tambien)

    //Offset util para manejar valores vectoriale x,y porq tiene gettes y se pueden operar entre ellos
    final offset = Offset.lerp(
      Offset(0, h),
      Offset(w * .25, h),
      animationValue,
    )!;
    print({offset: offset.dx, offset: offset.dy});

    final offset2 = Offset.lerp(
      Offset(w * .84, h),
      Offset(w, h),
      animationValue,
    )!;
    print({offset2: offset2.dx, offset2: offset.dy});

    final path = Path();
    path.lineTo(0, h);

    final firstCurvePoint = Offset(w * .25, h - 60);
    final firstEndPoint = Offset(w * 0.6, h - 29);

    path.quadraticBezierTo(
      firstCurvePoint.dx,
      firstCurvePoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    // path.quadraticBezierTo(
    //     offset.dx, firstCurvePoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    final secondCurvePoint = Offset(w * 0.84, h);
    final secondEndPoint = Offset(w, h - 10);

    // path.quadraticBezierTo(secondCurvePoint.dx, secondCurvePoint.dy,
    //     secondEndPoint.dx, secondEndPoint.dy);

    path.quadraticBezierTo(
      secondCurvePoint.dx,
      secondCurvePoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(w, 0);
    path.close();

    //clasic cuadrado
    // path.lineTo(0, h);
    // path.lineTo(w, h);
    // path.lineTo(w, 0);
    // path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

//CustomClipperestá restringiendo el área de pintura, mientras CustomPainter da un lienzo para pintar libremente.
class MyClipperTwo extends CustomClipper<Path> {
  final double animationValue;

  MyClipperTwo(this.animationValue);

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    //Lerp es util para interpolar entre dos valores en base a un valor de 0-1, como una animacion (en este caso da igual porq el offset dy es de 0 a 1 tambien)

    //Offset util para manejar valores vectoriale x,y porq tiene gettes y se pueden operar entre ellos
    final offset = Offset.lerp(
      Offset(0, h),
      Offset(w * .25, h),
      animationValue,
    )!;
    print({offset: offset.dx, offset: offset.dy});

    final offset2 = Offset.lerp(
      Offset(w * .84, h),
      Offset(w, h),
      animationValue,
    )!;
    print({offset2: offset2.dx, offset2: offset.dy});

    final path = Path();
    path.lineTo(0, h - 50);

    final firstCurvePoint = Offset(w * .25, h);
    final firstEndPoint = Offset(w * 0.6, h - 30);

    path.quadraticBezierTo(
      firstCurvePoint.dx,
      firstCurvePoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    // path.quadraticBezierTo(
    //     offset.dx, firstCurvePoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    final secondCurvePoint = Offset(w * 0.84, h - 50);
    final secondEndPoint = Offset(w, h - 40);

    path.quadraticBezierTo(
      secondCurvePoint.dx,
      secondCurvePoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    // path.quadraticBezierTo(secondCurvePoint.dx, secondCurvePoint.dy,
    //     secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(w, 0);
    path.close();

    //clasic cuadrado
    // path.lineTo(0, h);
    // path.lineTo(w, h);
    // path.lineTo(w, 0);
    // path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

//CustomClipperestá restringiendo el área de pintura, mientras CustomPainter da un lienzo para pintar libremente.
class MyClipperThree extends CustomClipper<Path> {
  final double animationValue;

  MyClipperThree(this.animationValue);

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height - 50;

    //Lerp es util para interpolar entre dos valores en base a un valor de 0-1, como una animacion (en este caso da igual porq el offset dy es de 0 a 1 tambien)

    //Offset util para manejar valores vectoriale x,y porq tiene gettes y se pueden operar entre ellos
    final offset = Offset.lerp(
      Offset(0, h),
      Offset(w * .25, h),
      animationValue,
    )!;
    print({offset: offset.dx, offset: offset.dy});

    final offset2 = Offset.lerp(
      Offset(w * .84, h),
      Offset(w, h),
      animationValue,
    )!;
    print({offset2: offset2.dx, offset2: offset.dy});

    final path = Path();
    path.lineTo(0, h);

    final firstCurvePoint = Offset(w * .28, h - 50);
    final firstEndPoint = Offset(w * 0.5, h - 25);

    path.quadraticBezierTo(
      offset.dx,
      firstCurvePoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondCurvePoint = Offset(w * 0.85, h + 20);
    final secondEndPoint = Offset(w, h + 20);

    path.quadraticBezierTo(
      secondCurvePoint.dx,
      secondCurvePoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(w, 0);
    path.close();

    //clasic cuadrado
    // path.lineTo(0, h);
    // path.lineTo(w, h);
    // path.lineTo(w, 0);
    // path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
