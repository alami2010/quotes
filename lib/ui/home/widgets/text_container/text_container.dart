import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quotez/data/model/quote.dart';
import 'package:quotez/theme/app_dimens.dart';

/// Widget that displays the text from [Quote].
class TextContainer extends StatefulWidget {
  final Quote randomQuote;

  const TextContainer({
    Key? key,
    required this.randomQuote,
  }) : super(key: key);

  @override
  _TextContainerState createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        right: AppDimens.paddingXL,
        left: AppDimens.paddingXL,
        top: (MediaQuery.of(context).size.height) *
            AppDimens.paddingPercentageS,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.randomQuote?.quotes ?? '',
            textAlign: TextAlign.center,
            style: GoogleFonts.alike(
              textStyle: Theme.of(context).primaryTextTheme.headline6,
            )
            ,
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height) *
                AppDimens.sizeUnitPercentageM,
          ),
          Text(
            "${widget.randomQuote.author}",
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.headline5,
          ),
        ],
      ),
    );
  }
}
