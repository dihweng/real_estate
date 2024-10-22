import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/helper_widgets.dart';
import 'caption_text.dart';

class AppTextField extends StatefulWidget {
  final Icon? icon;
  final TextInputType? textInputType;
  final TextInputType? keyboardType;
  final String labelText;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController textController;
  final bool autoFocus;
  final String?
  Function(String?)? validate;
  final bool isPassword;
  final bool readOnly;
  final String? prefixText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputAction textInputAction;
  final int? maxLines;
  final double? minLines;
  final double? height;
  final FocusNode? onFocus;
  final bool? enabled;
  final bool expands;
  final bool? showCursor;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? capitalization;
  final Color? labelTextColor;
  final Function(bool)? onFieldFocusChanged;

  const AppTextField({
    Key? key,
    this.icon,
    this.onFocus,
    this.readOnly = false,
    this.isPassword = false,
    this.enabled = true,
    this.expands = false,
    this.showCursor = true,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.contentPadding,
    this.textInputType,
    this.labelText = '',
    this.capitalization = TextCapitalization.words,
    required this.textController,
    required this.autoFocus,
    this.validate,
    this.onSaved,
    this.onChanged,
    this.maxLines,
    this.minLines,
    this.height = 52,
    this.hintText,
    this.prefixText,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.onFieldFocusChanged,
    this.labelTextColor = AppColors.textColorSecondary,
    this.obscureText = false,
    required this.textInputAction,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isError = false;
  // bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.onFocus ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    widget.textController.addListener(_onTextChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    widget.textController.removeListener(_onTextChange);
    if (widget.onFocus == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        _isError = false;
      });
    }
  }

  void _onTextChange() {
    if (widget.textController.text.isNotEmpty) {
      setState(() {
        _isError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.onFocus?.addListener(() {
      if (widget.onFieldFocusChanged != null) {
        widget.onFieldFocusChanged!(widget.onFocus!.hasFocus);
      }
    });

    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.labelText != ''
              ? CaptionText(
            text: widget.labelText,
            color: widget.labelTextColor,
          )
              : const SizedBox(),
          widget.labelText != '' ? addVerticalSpace(8) : const SizedBox(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: TextFormField(
                clipBehavior: Clip.hardEdge,
                readOnly: widget.readOnly,
                maxLines: widget.obscureText == true ? 1 : widget.maxLines,
                controller: widget.textController,
                textCapitalization: widget.capitalization!,
                validator: widget.validate,
                // validator: (value) {
                //   if (_isSubmitted) {
                //     return widget.validate != null ? widget.validate!(value) : null;
                //   }
                //   return null;  // Disable validation until submission
                // },
                onSaved: widget.onSaved,
                onChanged: (value) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                  setState(() {
                    _isError = value.isEmpty;
                  });
                },
                enabled: widget.enabled,
                showCursor: widget.showCursor,
                onFieldSubmitted: (value) {
                  if (widget.onFieldSubmitted != null) {
                    widget.onFieldSubmitted!(value);
                  }
                  setState(() {
                    _isError = widget.validate != null
                        ? widget.validate!(value) != null
                        : false;
                  });
                },
                onEditingComplete: () {
                  if (widget.onEditingComplete != null) {
                    widget.onEditingComplete!();
                  }
                  setState(() {
                    _isError = widget.validate != null
                        ? widget.validate!(widget.textController.text) != null
                        : false;
                  });
                  FocusScope.of(context).unfocus();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: AppColors.primaryColor,
                // cursorHeight: 16.0,
                textInputAction: widget.textInputAction,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.textInputType,
                obscureText: widget.obscureText,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hoverColor: Colors.black.withOpacity(0.2),
                  iconColor: Colors.black.withOpacity(0.6),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 16),
                  errorStyle: const TextStyle(
                      color: AppColors.primaryColor,
                      height: 0.7),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _isError ? AppColors.primaryColor :
                        AppColors.errorColor2, width: 0.7),
                    borderRadius: BorderRadius.circular(txInputBr),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 0.7),
                    borderRadius: BorderRadius.circular(txInputBr),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:   BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor, width: 0.7),
                    borderRadius: BorderRadius.circular(txInputBr),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 0.0),
                    borderRadius: BorderRadius.circular(txInputBr),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(txInputBr),
                    borderSide: const BorderSide(
                        color: Colors.green, width: 1.0),
                  ),
                  filled: true,
                  hintText: widget.hintText,
                  prefixText: widget.prefixText,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                  fillColor: Theme.of(context).cardColor,
                  suffixIcon: widget.suffixIcon,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}