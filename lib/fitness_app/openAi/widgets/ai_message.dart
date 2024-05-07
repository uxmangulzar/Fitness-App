import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Rendering state
enum RenderingState {
  /// Not rendered
  none,

  /// Rendering complete
  complete
}

/// AI Message class
class AiMessage extends StatefulWidget {
  /// Constructor
  const AiMessage({
    super.key,
    required this.text,
  });

  /// Message text
  final String text;

  @override
  State<AiMessage> createState() => _AiMessageState();
}

class _AiMessageState extends State<AiMessage> {
  RenderingState renderingState = RenderingState.none;
  Size renderSize = Size.zero;
  GlobalKey textKey = GlobalKey();
  bool _hasRendered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff444654),
      padding: const EdgeInsets.all(8),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
                padding: const EdgeInsets.all(3),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: renderingState != RenderingState.complete && !_hasRendered
                ? AnimatedTextKit(
                    key: textKey,
                    animatedTexts: [
                      TypewriterAnimatedText(widget.text,
                          textStyle:
                              styledText.copyWith(color: AppColors.kWhite)),
                    ],
                    onFinished: () {
                      setState(() {
                        _hasRendered = true;
                        renderingState = RenderingState.complete;
                        renderSize = (textKey.currentContext != null
                            ? textKey.currentContext!.size
                            : const Size(300, 100))!;
                      });
                    },
                    totalRepeatCount: 1,
                  )
                : SizedBox(
                    width: renderSize.width,
                    height: renderSize.height,
                    child: SelectableText.rich(
                      TextSpan(
                          text: widget.text,
                          style: styledText.copyWith(
                              fontSize: 16, color: AppColors.kWhite)),
                      onSelectionChanged: (selection, cause) async {
                        if (cause != null &&
                            cause == SelectionChangedCause.longPress) {
                          final selected = widget.text
                              .substring(selection.start, selection.end);
                          await Clipboard.setData(
                              ClipboardData(text: selected));
                        }
                      },
                    )),
          ),
        ],
      ),
    );
  }
}
