import 'package:flutter/material.dart';
import 'package:my_global_tools/utils/default_logger.dart';

import '../utils/sized_utils.dart';
import '../utils/text.dart';

enum ButtonLoadingState { idle, loading, completed, failed }

class MultiStageButton extends StatelessWidget {
  const MultiStageButton({
    super.key,
    required this.buttonLoadingState,
    this.enableCondition,
    required this.onPressed,
    this.idleColor,
    this.completedColor = Colors.green,
    this.failColor = Colors.red,
    this.loadingColor = Colors.grey,
    this.loadingTextColor,
    this.failTextColor,
    this.completedTextColor,
    this.idleTextColor,
    this.idleText = 'Proceed',
    this.completedText = 'Completed',
    this.failedText = 'Failed',
    this.helperText,
    this.loadingText,
    this.loadingIcon,
    this.idleIcon,
    this.failedIcon,
    this.completedIcon,
  });
  final ButtonLoadingState buttonLoadingState;
  final bool? enableCondition;
  final VoidCallback onPressed;
  final Color? idleColor;
  final Color completedColor;
  final Color failColor;
  final Color loadingColor;
  final Color? idleTextColor;
  final Color? completedTextColor;
  final Color? failTextColor;
  final Color? loadingTextColor;
  final String idleText;
  final String completedText;
  final String failedText;
  final String? loadingText;
  final String? helperText;
  final Widget? loadingIcon;
  final Widget? idleIcon;
  final Widget? failedIcon;
  final Widget? completedIcon;
  @override
  Widget build(BuildContext context) {
    infoLog('Button state is $buttonLoadingState');
    Color? textColor = buttonLoadingState == ButtonLoadingState.completed
        ? completedTextColor
        : buttonLoadingState == ButtonLoadingState.idle
            ? idleTextColor
            : buttonLoadingState == ButtonLoadingState.failed
                ? failTextColor
                : loadingTextColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: FilledButton(
              onPressed: enableCondition ??
                      (buttonLoadingState != ButtonLoadingState.loading)
                  ? () {
                      if (buttonLoadingState == ButtonLoadingState.idle) {
                        onPressed();
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      buttonLoadingState == ButtonLoadingState.completed
                          ? completedColor
                          : buttonLoadingState == ButtonLoadingState.idle
                              ? idleColor
                              : buttonLoadingState == ButtonLoadingState.failed
                                  ? failColor
                                  : loadingColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: buttonLoadingState == ButtonLoadingState.loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            width: 30,
                            height: 30,
                            child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))),
                        if (loadingText != null)
                          Row(
                            children: [
                              width10(),
                              bodyLargeText(loadingText!, context,
                                  color: textColor ?? Colors.white),
                            ],
                          )
                      ],
                    )
                  : buttonLoadingState == ButtonLoadingState.failed
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (failedIcon != null)
                              Row(
                                children: [
                                  failedIcon!,
                                  width5(),
                                ],
                              ),
                            bodyLargeText(failedText, context,
                                color: textColor ?? Colors.white)
                          ],
                        )
                      : buttonLoadingState == ButtonLoadingState.completed
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (completedIcon != null)
                                  Row(
                                    children: [
                                      completedIcon!,
                                      width5(),
                                    ],
                                  ),
                                bodyLargeText(completedText, context,
                                    color: textColor ?? Colors.white)
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (idleIcon != null)
                                  Row(
                                    children: [
                                      idleIcon!,
                                      width5(),
                                    ],
                                  ),
                                titleLargeText(idleText, context,
                                    color: textColor ?? Colors.white),
                              ],
                            ),
            ))
          ],
        ),
        if (helperText != null)
          capText(
            helperText!,
            context,
            color: buttonLoadingState == ButtonLoadingState.completed
                ? completedTextColor ?? completedColor
                : buttonLoadingState == ButtonLoadingState.idle
                    ? idleTextColor ?? idleColor
                    : buttonLoadingState == ButtonLoadingState.failed
                        ? failTextColor ?? failColor
                        : loadingTextColor ?? loadingColor,
          )
      ],
    );
  }
}
