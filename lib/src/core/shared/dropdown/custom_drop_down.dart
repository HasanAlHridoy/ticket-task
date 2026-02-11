import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/gap.dart';

/// Old data
class CustomDropDown extends StatelessWidget {
  final String? label;
  final String hintText; // Hint text inside the button
  final List<dynamic> options;
  final dynamic selectedValue;
  final ValueChanged<dynamic> onSelectionChanged;
  final TextStyle? selectedTextStyle;
  final double? width;
  final double? verticalPadding; // Vertical padding for the dropdown
  final double? height; // Default height for the dropdown
  final bool? showBorder; // Whether to show a border around the dropdown
  final double? dropdownListFontSize; // Default font size for dropdown items
  final double? horizontalPadding;
  final double? iconSize;
  final FontWeight? fontWeight;
  final Widget? leading;
  final Widget? iconButton;
  final bool? showtrailingButton;
  final bool? isRequired;
  final Color? fillColor;
  final Color? menuBackgroundColor;

  const CustomDropDown({
    super.key,
    required this.label,
    required this.hintText,
    required this.options,
    required this.selectedValue,
    required this.onSelectionChanged,
    this.width,
    this.leading,
    this.selectedTextStyle,
    this.dropdownListFontSize,
    this.showBorder = true,
    this.height,
    this.verticalPadding,
    this.horizontalPadding,
    this.iconSize,
    this.fontWeight,
    this.iconButton,
    this.showtrailingButton = false,
    this.isRequired = true,
    this.fillColor,
    this.menuBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Row(
            children: [
              Text(
                label ?? '',
                style: context.text.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.theme.primaryColorDark,
                ),
              ),
              if (isRequired == true)
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
                ),
            ],
          ),
          8.ph,
        ],

        MenuAnchor(
          style: MenuStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            backgroundColor: WidgetStateProperty.all(menuBackgroundColor ?? context.theme.canvasColor),
            elevation: WidgetStateProperty.all(8),
            maximumSize: height == null ? null : WidgetStateProperty.all(Size(double.infinity, height!)),
          ),
          menuChildren: options.map((option) {
            final isSelected = selectedValue == option;
            return Container(
              width: width ?? context.width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: MenuItemButton(
                onPressed: () {
                  onSelectionChanged(option);
                },
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? context.theme.primaryColor : context.theme.primaryColorDark,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: dropdownListFontSize ?? 14.sp, // Use the provided font size or default to 14.sp
                  ),
                ),
              ),
            );
          }).toList(),
          builder: (context, controller, child) {
            return GestureDetector(
              onTap: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: Container(
                padding: showBorder!
                    ? EdgeInsets.symmetric(horizontal: horizontalPadding ?? 14.w, vertical: verticalPadding ?? 12.h)
                    : const EdgeInsets.fromLTRB(16, 0, 0, 0),
                margin: !showBorder! ? EdgeInsets.fromLTRB(0, 8.h, 14.w, 8.h) : null,
                decoration: BoxDecoration(
                  border: showBorder!
                      ? Border.all(color: context.theme.unselectedWidgetColor.withValues(alpha: 0.2))
                      : null,
                  borderRadius: showBorder! ? BorderRadius.circular(32) : null,
                  color: fillColor ?? context.theme.canvasColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          leading ?? const SizedBox.shrink(),
                          Expanded(
                            child: Text(
                              selectedValue ?? hintText,
                              style:
                                  selectedTextStyle ??
                                  context.text.titleSmall?.copyWith(
                                    fontWeight:
                                        fontWeight ?? (selectedValue != null ? FontWeight.w500 : FontWeight.w500),
                                    color: selectedValue == null
                                        ? context.theme.unselectedWidgetColor
                                        : context.theme.primaryColorDark,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    showtrailingButton == true
                        ? iconButton!
                        : controller.isOpen
                        ? Icon(Icons.arrow_drop_up_sharp, color: context.theme.primaryColorDark, size: iconSize ?? 24)
                        : Icon(
                            Icons.arrow_drop_down_sharp,
                            color: context.theme.primaryColorDark,
                            size: iconSize ?? 24,
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
