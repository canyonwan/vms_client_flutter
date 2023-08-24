part of widgets;

class CustomSwitch extends CupertinoSwitch {
  const CustomSwitch({
    Key? key,
    required bool value,
    required ValueChanged<bool>? onChanged,
    Color? activeColor,
    Color? trackColor,
  }) : super(
          key: key,
          value: value,
          onChanged: onChanged,
          activeColor: activeColor ?? AppTheme.primary,
          trackColor: trackColor ?? const Color(0xFF9098A1),
        );
}
