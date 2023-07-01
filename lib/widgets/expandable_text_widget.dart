import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/text_font_small.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late final firstLines;
  late final restOfText;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    print(textHeight);
    if (widget.text.length > textHeight) {
      firstLines = widget.text.substring(0, textHeight.toInt());
      restOfText =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstLines = widget.text;
      restOfText = ""; //empty string
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: restOfText.isEmpty
          ? SmallText(
              text: firstLines,
              size: Dimensions.font16,
              color: AppColors.paraColor,
              height: 1.6,
            )
          : Column(
              children: [
                SmallText(
                  text: hiddenText
                      ? (firstLines + "...")
                      : (firstLines + restOfText),
                  size: Dimensions.font16,
                  color: AppColors.paraColor,
                  height: 1.6,
                ),
                //Show More button
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                          text: hiddenText ? 'Show more' : 'Show less',
                          color: AppColors.mainColor),
                      Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
