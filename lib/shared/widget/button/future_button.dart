import 'package:flutter/material.dart';

class FutureButton extends StatefulWidget {
  final Future Function() onPressed;
  final String text;

  const FutureButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  State<FutureButton> createState() => _FutureButtonState();
}

class _FutureButtonState extends State<FutureButton> {
  bool _loading = false;

  _handlePress() async {
    setState(() {
      _loading = true;
    });

    try {
      await widget.onPressed();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _loading ? null : _handlePress,
      child: _loading ? const CircularProgressIndicator() : Text(widget.text),
    );
  }
}
