import 'package:flutter/material.dart';

class ResponsiveLayout {
  const ResponsiveLayout._(this.width);

  final double width;

  bool get isCompact => width < 600;
  bool get isMedium => width >= 600 && width < 980;
  bool get isWide => width >= 980;
  bool get isVeryNarrow => width < 390;

  double get pagePadding => isCompact ? 16 : (isMedium ? 22 : 28);
  double get panelPadding => isCompact ? 16 : 20;
  double get gap => isCompact ? 14 : 18;
  double get headerGap => isCompact ? 16 : 22;
  double get maxContentWidth => isWide ? 1220 : double.infinity;
  double get bottomContentPadding => isCompact ? 104 : 118;
  double get statTileWidth => isCompact ? double.infinity : 178;
  double get navMaxWidth => isCompact ? 560 : 720;
  double get navHorizontalPadding => isCompact ? 12 : 16;
  double get navBottomPadding => isCompact ? 12 : 16;
  double get navItemHeight => isCompact ? 52 : 56;
  double get navItemPadding => isCompact ? 6 : 10;
  double get iconButtonSize => isCompact ? 44 : 48;
  double get dialogMaxWidth => isCompact ? width - 48 : 420;
  double get timelineTimeWidth => isCompact ? 48 : 52;

  EdgeInsets get pageInsets => EdgeInsets.fromLTRB(
    pagePadding,
    pagePadding,
    pagePadding,
    bottomContentPadding,
  );

  static ResponsiveLayout of(BuildContext context) {
    return ResponsiveLayout._(MediaQuery.sizeOf(context).width);
  }
}
