part of widgets;

class CustomTag extends StatelessWidget {
  final Widget text;
  final Color? color;

  const CustomTag({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final surfaceColor = color ?? Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 7.w,
      ),
      decoration: ShapeDecoration(
        color: surfaceColor.withOpacity(0.1),
        shape: const StadiumBorder(),
      ),
      child: DefaultTextStyle.merge(
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.w,
          fontWeight: FontWeight.w600,
          color: surfaceColor,
          height: 1.2,
        ),
        child: text,
      ),
    );
  }
}
