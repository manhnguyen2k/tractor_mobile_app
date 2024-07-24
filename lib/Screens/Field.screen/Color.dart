import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ColorPickerPage extends StatefulWidget {
  final ValueChanged<Color> onColorChanged;

  ColorPickerPage({required this.onColorChanged});

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  late Color dialogPickerColor;

  @override
  void initState() {
    dialogPickerColor = Colors.red;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColorIndicator(
      width: 44,
      height: 44,
      borderRadius: 22,
      color: dialogPickerColor,
      onSelectFocus: false,
      onSelect: () async {
        final Color colorBeforeDialog = dialogPickerColor;
        if (!(await colorPickerDialog())) {
          setState(() {
            dialogPickerColor = colorBeforeDialog;
          });
        }
        widget.onColorChanged(dialogPickerColor);
      },
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 20,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: false,
      },
    ).showPickerDialog(
      context,
      actionsPadding: const EdgeInsets.all(16),
      constraints:
          const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }
}
