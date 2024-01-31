import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EditableChipField extends StatefulWidget {
  final List<String> initialValues;
  final ValueChanged<List<String>> onChanged;
  final int? maxLine;
  const EditableChipField({
    super.key,
    required this.onChanged,
    required this.initialValues,
    this.maxLine,
  });

  @override
  EditableChipFieldState createState() {
    return EditableChipFieldState();
  }
}

class EditableChipFieldState extends State<EditableChipField> {

  late List<String> menuItems;

  @override
  void initState() {
    super.initState();
    menuItems = widget.initialValues;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ChipsInput<String>(
          values: menuItems,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.local_pizza_rounded),
            hintText: 'Enter menu Items',
          ),
          strutStyle: const StrutStyle(fontSize: 15),
          onChanged: _onChanged,
          onSubmitted: _onSubmitted,
          chipBuilder: _chipBuilder,
          maxLine: widget.maxLine,
          // onTextChanged: _onSearchChanged,
        ),
      ],
    );
  }


  Widget _chipBuilder(BuildContext context, String topping) {
    return MenuInputChip(
      menuItem: topping,
      onDeleted: _onChipDeleted,
      onSelected: _onChipTapped,
    );
  }


  void _onChipTapped(String menuItem) {}

  void _onChipDeleted(String menuItem) {
    setState(() {
      menuItems.remove(menuItem);
    });
    widget.onChanged(menuItems);
  }

  void _onSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        menuItems = <String>[...menuItems, text.trim()];
      });

      // Check if the Enter key is pressed
      if (RawKeyboard.instance.keysPressed.contains(LogicalKeyboardKey.enter)) {
        // If Enter key is not pressed, request focus to keep the keyboard open
        FocusScope.of(context).requestFocus(FocusNode());
      }
      widget.onChanged(menuItems);
    }
  }

  void _onChanged(List<String> data) {
    setState(() {
      menuItems = data;
    });
  }

}

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    super.key,
    required this.values,
    this.decoration = const InputDecoration(),
    this.style,
    this.strutStyle,
    required this.chipBuilder,
    required this.onChanged,
    this.onChipTapped,
    this.onSubmitted,
    this.onTextChanged,
    this.maxLine = 3,
  });

  final List<T> values;
  final InputDecoration decoration;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final int? maxLine;

  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T>? onChipTapped;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onTextChanged;

  final Widget Function(BuildContext context, T data) chipBuilder;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>> {
  @visibleForTesting
  late final ChipsInputEditingController<T> controller;


  String _previousText = '';
  TextSelection? _previousSelection;

  @override
  void initState() {
    super.initState();
    controller = ChipsInputEditingController<T>(
      <T>[...widget.values],
      widget.chipBuilder,
    );
    controller.addListener(_textListener);
  }

  @override
  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();

    super.dispose();
  }

  void _textListener() {
    final String currentText = controller.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<T> values = <T>[...widget.values];

      // If the current number and the previous number of replacements are different, then
      // the user has deleted the InputChip using the keyboard. In this case, we trigger
      // the onChanged callback. We need to be sure also that the current number of
      // replacements is different from the input chip to avoid double-deletion.
      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            values.removeRange(cursorEnd, cursorStart);
          } else {
            values.removeRange(cursorStart, cursorEnd);
          }
        }
        widget.onChanged(values);
      }
    }

    _previousText = currentText;
    _previousSelection = controller.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits
        .where(
            (int u) => u == ChipsInputEditingController.kObjectReplacementChar)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateValues(<T>[...widget.values]);

    return TextField(
      minLines: 1,
      maxLines: widget.maxLine,
      style: widget.style,
      strutStyle: widget.strutStyle,
      controller: controller,
      onChanged: (String value) =>
          widget.onTextChanged?.call(controller.textWithoutReplacements),
      onSubmitted: (String value) {
        widget.onSubmitted?.call(controller.textWithoutReplacements);
        controller.clear();
      },
      onEditingComplete: (){
        FocusScope.of(context).requestFocus();
      },
      textInputAction: TextInputAction.done,
    );
  }
}

class ChipsInputEditingController<T> extends TextEditingController {
  ChipsInputEditingController(this.values, this.chipBuilder)
      : super(
    text: String.fromCharCode(kObjectReplacementChar) * values.length,
  );

  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputChip displayed.
  static const int kObjectReplacementChar = 0xFFFE;

  List<T> values;

  final Widget Function(BuildContext context, T data) chipBuilder;

  /// Called whenever chip is either added or removed
  /// from the outside the context of the text field.
  void updateValues(List<T> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
        TextStyle? style,
        required bool withComposing}) {
    final Iterable<WidgetSpan> chipWidgets =
    values.map((T v) => WidgetSpan(child: chipBuilder(context, v)));

    return TextSpan(
      style: style,
      children: <InlineSpan>[
        ...chipWidgets,
        if (textWithoutReplacements.isNotEmpty)
          TextSpan(text: textWithoutReplacements)
      ],
    );
  }
}

class MenuInputChip extends StatelessWidget {
  const MenuInputChip({
    super.key,
    required this.menuItem,
    required this.onDeleted,
    required this.onSelected,
  });

  final String menuItem;
  final ValueChanged<String> onDeleted;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        child: InputChip(
          deleteIconColor: Theme.of(context).iconTheme.color,
          key: ObjectKey(menuItem),
          label: Text(menuItem),
          onDeleted: () => onDeleted(menuItem),
          onSelected: (bool value) => onSelected(menuItem),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.all(2.w),
        ),
      ),
    );
  }
}
