import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  //===========================================================================
  // Body text style
  static get bodyLargeGray600 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray600,
      );
  static get bodyLargeGray800 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray800,
      );
  static get bodyLargeGray80017 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray800,
        fontSize: 17.fSize,
      );
  static get bodyLargeGray80020 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray600,
        fontSize: 20.fSize,
      );
  static get bodyLargeLightblueA700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.lightBlueA700,
      );
  static get bodyLargeLightblueA700PopUp => theme.textTheme.bodyLarge!
      .copyWith(color: appTheme.lightBlueA700, fontSize: 20);

  static get bodyLargeLightblueA700PopUpBold =>
      theme.textTheme.bodyLarge!.copyWith(
          color: appTheme.lightBlueA700,
          fontSize: 20,
          fontWeight: FontWeight.bold);

  static get bodyLargeOnPrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get bodyMediumAmber600 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.amber600,
      );
  static get bodySmallffa7a7a7 => theme.textTheme.bodySmall!.copyWith(
        color: const Color(0XFFA7A7A7),
      );
  static get bodySmallffffb700 => theme.textTheme.bodySmall!.copyWith(
        color: const Color(0XFFFFB700),
      );
  // Label text style
  static get labelLargeSFProTextGray600 =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: appTheme.gray600,
      );
  static get labelMediumLightblueA700 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.lightBlueA700,
      );
}

extension on TextStyle {
  TextStyle get sFProText {
    return copyWith(
      fontFamily: 'SF Pro Text',
    );
  }
}
