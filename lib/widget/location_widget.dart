import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ttravel_mate/model/location.dart';
import 'package:ttravel_mate/widget/image_widget.dart';
import 'package:ttravel_mate/widget/expand_content_widget.dart';

import 'expand_content_widget.dart';

class LocationWidget extends StatefulWidget {
  final Location location;
  const LocationWidget({Key? key, required this.location}) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? size.width * 0.78 : size.width * 0.7,
            height: isExpanded ? size.height * 0.5: size.height * 0.4,
            child: ExpandContentWidget(location: widget.location),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              //onPanUpdate: onPanUpdate,
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: ImageWidget(location: widget.location),
            ),
          ),
        ],
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}

