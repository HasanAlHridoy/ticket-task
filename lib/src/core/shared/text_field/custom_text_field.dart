import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final bool? obscureText;
  final int? maxLines;
  final String? isRequired;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? leading;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final Color? isRequiredColor;
  final TextStyle? labelStyle;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final bool filled;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final ValueChanged<dynamic>? onFieldSubmitted;

  // New Border Properties
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;

  const CustomTextFieldWithLabel({
    super.key,
    required this.label,
    this.hintText,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.isRequired,
    this.readOnly,
    this.onTap,
    this.trailing,
    this.leading,
    this.controller,
    this.validator,
    this.obscureText,
    this.autofillHints,
    this.maxLines,
    this.isRequiredColor,
    this.labelStyle,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.enabled,
    this.filled = true,
    this.fillColor,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    // Initialize borders
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.onFieldSubmitted,
    this.helperText,
    this.helperStyle,
  });

  // Helper Text
  final String? helperText;
  final TextStyle? helperStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Row(
            children: [
              Text(label, style: labelStyle ?? context.text.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
              Text(
                isRequired ?? '',
                style: context.text.titleSmall!.copyWith(color: isRequiredColor ?? context.theme.primaryColorDark),
              ),
            ],
          ),
        if (label.isNotEmpty) SizedBox(height: 8.h),
        TextFormField(
          onTap: onTap,
          focusNode: focusNode,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          controller: controller,
          maxLines: maxLines ?? 1,
          style: context.text.titleSmall!,
          maxLength: maxLength,
          obscureText: obscureText ?? false,
          enabled: enabled,
          decoration: InputDecoration(
            errorStyle: const TextStyle(color: Colors.red),
            hintText: hintText,
            hintStyle: context.text.titleSmall!.copyWith(
              color: context.theme.dividerColor,
              fontWeight: FontWeight.w500,
            ),
            isDense: true,
            prefixIcon: leading,
            suffixIcon: trailing,
            helperText: helperText,
            helperStyle: helperStyle,
            contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
            fillColor: fillColor ?? context.theme.canvasColor,
            filled: filled,

            // Apply the borders here
            border: border,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedErrorBorder,
          ),
          readOnly: readOnly ?? false,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: keyboardType ?? TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: autofillHints,
          validator:
              validator ??
              (v) {
                if (isRequired != '*') return null;
                if (v == null || v.isEmpty) {
                  return '$label required';
                }
                return null;
              },
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onFieldSubmitted: onFieldSubmitted,
        ),
      ],
    );
  }
}
