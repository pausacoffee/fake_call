import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import '../utils/text.dart';

class GlobalToggleSwitch extends StatefulWidget {
  const GlobalToggleSwitch({
    super.key,
    required this.current,
    required this.first,
    required this.second,
    required this.onChanged,
    required this.firstString,
    required this.secondString,
    this.height,
  });

  final bool current;
  final bool first;
  final bool second;
  final Function(bool) onChanged;
  final String firstString;
  final String secondString;
  final double? height;

  @override
  State<GlobalToggleSwitch> createState() => _GlobalToggleSwitchState();
}

class _GlobalToggleSwitchState extends State<GlobalToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      current: widget.current,
      first: widget.first,
      second: widget.second,
      dif: 50.0,
      borderColor: Colors.transparent,
      borderWidth: 3.0,
      height: widget.height ?? 50,
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 0.5),
        ),
      ],
      onChanged: (b) {
        setState(() => widget.onChanged(b));
      },
      colorBuilder: (b) => b ? Colors.purple[200] : Colors.blue[200],
      iconBuilder: (value) => value
          ? Text(
              widget.firstString,
              style: TextStylePath.small14w600,
            )
          : Text(
              widget.secondString,
              style: TextStylePath.small14w600,
            ),
    );
  }
}
