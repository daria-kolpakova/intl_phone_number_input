import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/utils/util.dart';

/// [Item]
class Item extends StatelessWidget {
  final Country? country;
  final bool? showFlag;
  final bool? useEmoji;
  final TextStyle? textStyle;
  final bool withCountryNames;
  final bool trailingSpace;
  final InputBorder inputBorder;

  const Item({
    Key? key,
    this.country,
    this.showFlag,
    this.useEmoji,
    this.textStyle,
    this.withCountryNames = false,
    this.trailingSpace = true,
    required this.inputBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dialCode = (country?.dialCode ?? '');
    if (trailingSpace) {
      dialCode = dialCode.padRight(5, "   ");
    }
    return SizedBox(
      width: 120.0,
      child: TextField(
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          border: inputBorder,
          disabledBorder: inputBorder,
          prefixIcon: _Flag(
            country: country,
            showFlag: showFlag,
            useEmoji: useEmoji,
          ),
          hintText: '$dialCode',
          hintStyle: textStyle,
          enabled: false,
        ),
      ),
    );
  }
}

class _Flag extends StatelessWidget {
  final Country? country;
  final bool? showFlag;
  final bool? useEmoji;

  const _Flag({Key? key, this.country, this.showFlag, this.useEmoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return country != null && showFlag!
        ? Container(
            child: useEmoji!
                ? Text(
                    Utils.generateFlagEmojiUnicode(country?.alpha2Code ?? ''),
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Image.asset(
                      country!.flagUri,
                      width: 32.0,
                      package: 'intl_phone_number_input',
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox.shrink();
                      },
                    ),
                  ),
          )
        : SizedBox.shrink();
  }
}
