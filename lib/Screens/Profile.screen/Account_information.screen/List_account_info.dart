import 'package:flutter/material.dart';
import 'dart:developer';

class ItemAccountInfo extends StatefulWidget {
  const ItemAccountInfo({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.canEdit = false,
    this.textColor,
  }) : super(key: key);

  final String title;
  final Icon icon;
  final VoidCallback onPress;
  final bool canEdit;
  final Color? textColor;

  @override
  _ItemAccountInfoState createState() => _ItemAccountInfoState();
}

class _ItemAccountInfoState extends State<ItemAccountInfo> {
  bool isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.title);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leadingColor = theme.listTileTheme.iconColor;
    final titleStyle = theme.listTileTheme.titleTextStyle;
    final tileColor = theme.listTileTheme.tileColor;
    //   log('tileeeeee $tileColor');
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50.0,
      ),
      height: 60,
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          tileColor: tileColor,
          leading: Container(
            width: 40,
            height: 40,
            child: widget.icon,
          ),
          title: isEditing
              ? TextField(
                  controller: _controller,
                  style: titleStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: 'Enter new title',
                    hintStyle: titleStyle?.copyWith(color: Colors.grey),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      isEditing = false;
                    });
                    widget.onPress();
                  },
                )
              : Text(
                  _controller.text,
                  style: widget.canEdit
                      ? titleStyle
                      : titleStyle?.copyWith(color: Colors.grey),
                ),
          trailing: widget.canEdit
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Icon(
                      isEditing ? Icons.check : Icons.edit,
                      size: 20.0,
                      color: leadingColor,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
