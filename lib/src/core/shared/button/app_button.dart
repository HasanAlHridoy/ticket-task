import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';

// 1. Define an enum to represent button types
enum _AppButtonType { elevated, filled, filledTonal, outlined, text }

class AppButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double? width;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Color? underlineColor;
  final BorderSide? borderSide;
  final double? height;
  final Color? outlineButtonBorderColor;
  final double? borderWidth;
  final double? borderRadius;
  final MaterialTapTargetSize? tapTargetSize;
  final VisualDensity? visualDensity;
  // 2. Add a private field to store the button type
  final _AppButtonType _type;

  /// Private constructor for named factories
  const AppButton._({
    required this.child,
    required this.onPressed,
    this.width,
    this.color,
    this.textColor,
    this.textStyle,
    this.padding,
    this.underlineColor,
    this.borderSide,
    this.height,
    this.outlineButtonBorderColor,
    this.borderWidth,
    this.borderRadius,
    this.tapTargetSize,
    this.visualDensity,
    required _AppButtonType type, // 3. Require the type in the private constructor
  }) : _type = type; // 4. Initialize the type

  // --- STATIC FACTORY CONSTRUCTORS ---

  /// Elevated button
  factory AppButton.elevated({
    required Widget child,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? color,
    Color? textColor,
    TextStyle? textStyle,
    EdgeInsets? padding,
    double? borderRadius,
  }) {
    return AppButton._(
      onPressed: onPressed,
      width: width,
      height: height,
      color: color,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding,
      borderRadius: borderRadius,
      type: _AppButtonType.elevated,
      child: child, // 5. Assign the type
    );
  }

  /// Filled button
  factory AppButton.filled({
    required Widget child,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? color,
    Color? textColor,
    TextStyle? textStyle,
    EdgeInsets? padding,
    BorderSide? borderSide,
    double? borderRadius,
  }) {
    return AppButton._(
      onPressed: onPressed,
      width: width,
      height: height,
      color: color,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding,
      borderSide: borderSide,
      borderRadius: borderRadius,
      type: _AppButtonType.filled,
      child: child, // 5. Assign the type
    );
  }

  /// Filled tonal button
  factory AppButton.filledTonal({
    required Widget child,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? color,
    Color? textColor,
    TextStyle? textStyle,
    EdgeInsets? padding,
    double? borderRadius,
  }) {
    return AppButton._(
      onPressed: onPressed,
      width: width,
      height: height,
      color: color,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding,
      borderRadius: borderRadius,
      type: _AppButtonType.filledTonal,
      child: child, // 5. Assign the type
    );
  }

  /// Outlined button
  factory AppButton.outlined({
    required Widget child,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? color,
    Color? outlineButtonBorderColor,
    double? borderWidth,
    double? borderRadius,
    TextStyle? textStyle,
    EdgeInsets? padding,
  }) {
    return AppButton._(
      onPressed: onPressed,
      width: width,
      height: height,
      color: color,
      outlineButtonBorderColor: outlineButtonBorderColor,
      borderWidth: borderWidth,
      textStyle: textStyle,
      padding: padding,
      borderRadius: borderRadius,
      type: _AppButtonType.outlined,
      child: child, // 5. Assign the type
    );
  }

  /// Text button
  factory AppButton.text({
    required Widget child,
    VoidCallback? onPressed,
    Color? color,
    TextStyle? textStyle,
    EdgeInsets? padding,
    double? borderRadius,
    Color? underlineColor,
    MaterialTapTargetSize? tapTargetSize,
    VisualDensity? visualDensity,
  }) {
    return AppButton._(
      onPressed: onPressed,
      color: color,
      textStyle: textStyle,
      padding: padding,
      borderRadius: borderRadius,
      underlineColor: underlineColor,
      tapTargetSize: tapTargetSize,
      visualDensity: visualDensity,
      type: _AppButtonType.text,
      child: child, // 5. Assign the type
    );
  }

  @override
  Widget build(BuildContext context) {
    // 6. Use a switch statement on the _type to render the correct button
    switch (_type) {
      case _AppButtonType.filled:
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: color ?? context.theme.primaryColor,
            foregroundColor: textColor ?? Colors.white,
            minimumSize: Size(width ?? double.infinity, height ?? 45.h),
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 18),
            textStyle: textStyle ?? context.text.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            side: borderSide, // This can be null for FilledButton too
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 44)),
          ),
          child: child,
        );
      case _AppButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size(width ?? double.infinity, height ?? 45.h),
            side: BorderSide(
              color: outlineButtonBorderColor ?? context.theme.unselectedWidgetColor,
              width: borderWidth ?? 0.3,
            ),
            backgroundColor: color ?? context.theme.canvasColor,
            textStyle:
                textStyle ??
                context.text.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: context.text.bodyMedium?.color),
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 44)),
          ),
          child: child,
        );
      case _AppButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: padding ?? EdgeInsets.zero,
            foregroundColor: color ?? context.theme.primaryColorDark,
            tapTargetSize: tapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
            visualDensity: visualDensity ?? VisualDensity.compact,
            textStyle:
                textStyle ??
                context.text.titleSmall?.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: underlineColor ?? context.theme.primaryColorDark,
                ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 44)),
          ),
          child: child,
        );
      case _AppButtonType.filledTonal:
        // Filled tonal button doesn't have a direct Flutter widget,
        // so you'd typically implement it as an ElevatedButton with a specific background color,
        // or a custom button. For this example, I'll make it an ElevatedButton with a tonal color.
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? context.theme.primaryColor.withValues(alpha: 0.1), // Example tonal color
            foregroundColor: textColor ?? context.theme.primaryColor, // Example tonal text color
            minimumSize: Size(width ?? double.infinity, height ?? 45.h),
            textStyle: textStyle ?? context.text.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 44)),
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 18),
          ),
          child: child,
        );
      case _AppButtonType.elevated:
      default: // This will handle the default case and _AppButtonType.elevated
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? context.theme.primaryColor,
            // foregroundColor: textColor ?? context.theme.primaryColorDark,
            minimumSize: Size(width ?? double.infinity, height ?? 45.h),
            textStyle:
                textStyle ??
                context.text.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor ?? context.theme.primaryColorDark,
                ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 44)),
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 18),
          ),
          child: child,
        );
    }
  }
}
