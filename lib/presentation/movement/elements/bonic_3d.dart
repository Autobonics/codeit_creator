import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_3d_renderer/simple_3d_renderer.dart';
import 'package:simple_3d/simple_3d.dart';
import 'package:util_simple_3d/util_simple_3d.dart';

class Bonic3D extends StatefulWidget {
  final double rotateX;
  final double rotateY;
  final double size;
  final Color mainColor;

  const Bonic3D({
    Key? key,
    required this.rotateX,
    required this.rotateY,
    required this.size,
    required this.mainColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Bonic3DState();
}

class _Bonic3DState extends State<Bonic3D> {
  late List<Sp3dObj> objs = [];
  late Sp3dWorld world;
  bool isLoaded = false;
  double currentXAngle = 0;
  double currentYAngle = 0;
  late Sp3dCamera camera;
  late double currentCubeSize;
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    // Create Sp3dObj.
    _addCube();
    camera = Sp3dCamera(Sp3dV3D(0, 0, 3000), 6000);
    loadImage();
  }

  _addCube() {
    currentCubeSize = widget.size;
    Sp3dObj obj = UtilSp3dGeometry.cube(
        currentCubeSize, currentCubeSize, currentCubeSize * 0.2, 1, 1, 1);

    // Sp3dObj obj = UtilSp3dGeometry.sphere(currentCubeSize);

    // obj.materials.add(FSp3dMaterial.green.deepCopy());
    // obj.materials.add(FSp3dMaterial.red.deepCopy());
    obj.fragments[0].faces.forEach((face) {
      face.materialIndex = 1;
    });

    obj.fragments[0].faces[0].materialIndex = 0;
    // obj.fragments[0].faces[1].materialIndex = 1;
    // obj.materials[0] = FSp3dMaterial.grey.deepCopy()..strokeColor = Colors.grey;
    // obj.rotate(Sp3dV3D(1, 0, 0).nor(), 30 * 3.14 / 180);

    objs.add(obj);

    objs[0].rotate(Sp3dV3D(1, 0, 0).nor(), -90 * 3.14 / 180);

    _addMaterial();
    obj.materials[0].imageIndex = 0;
  }

  _removeCube() {
    if (objs.length > 0) objs.removeLast();
  }

  _addMaterial() {
    currentColor = widget.mainColor;
    objs[0].materials.add(Sp3dMaterial(currentColor, true, 3, Colors.white));
  }

  _removeMaterial() {
    if (objs[0].materials.length > 0) objs[0].materials.removeLast();
  }

  void loadImage() async {
    this
        .objs[0]
        .images
        .add(await _readFileBytes("assets/creator/orientation/face.png"));
    world = Sp3dWorld(objs);
    world.initImages().then((List<Sp3dObj> errorObjs) {
      setState(() {
        isLoaded = true;
      });
    });
  }

  Future<Uint8List> _readFileBytes(String filePath) async {
    ByteData bd = await rootBundle.load(filePath);
    return bd.buffer.asUint8List(bd.offsetInBytes, bd.lengthInBytes);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.size != currentCubeSize) {
      _removeCube();
      _addCube();
    }

    if (widget.mainColor != currentColor) {
      _removeMaterial();
      _addMaterial();
    }

    double radianX = (widget.rotateX) * pi / 180;
    double radianY = (widget.rotateY) * pi / 180;

    double cx = cos(radianX);
    double cy = cos(radianY);
    double sx = sin(radianX);
    double sy = sin(radianY);

    double angle = acos((cy + cx + (cx * cy) - 1) / 2);
    double x = (-sx * cy) - sx;
    double y = (-cx * sy) - sy;
    double z = -sx * sy;

    camera.rotate(Sp3dV3D(x, y, z).nor(), angle);

    if (!isLoaded) {
      return Container();
    } else {
      return Sp3dRenderer(
        Size(widget.size, widget.size),
        Sp3dV2D(widget.size / 2, widget.size / 2),
        world,
        camera,
        Sp3dLight(Sp3dV3D(0, 0, -1), syncCam: true),
        useUserGesture: false,
      );
    }
  }
}
