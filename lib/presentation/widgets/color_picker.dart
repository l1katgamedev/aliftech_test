import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorSelected;

  const ColorPicker({super.key, required this.initialColor, required this.onColorSelected});

  @override
  ColorPickerState createState() => ColorPickerState();
}

class ColorPickerState extends State<ColorPicker> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  void _onColorChanged(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _selectColor() {
    widget.onColorSelected(_selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pick a color',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  _buildColorOption(Colors.red),
                  _buildColorOption(Colors.green),
                  _buildColorOption(Colors.blue),
                  _buildColorOption(Colors.yellow),
                  _buildColorOption(Colors.orange),
                  _buildColorOption(Colors.purple),
                  _buildColorOption(Colors.cyan),
                  _buildColorOption(Colors.pink),
                  _buildColorOption(Colors.brown),
                  _buildColorOption(Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectColor,
              child: const Text('Select'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    bool isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () => _onColorChanged(color),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
