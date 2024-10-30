import 'package:flutter/material.dart';

/// ### 自定义下划线指示器
///
/// - 使用 [width] 设置下划线长度
/// - 使用 [borderSide] 设置下划线宽度和颜色，它会覆盖[TabBar.indicatorPadding]
class CustomUnderlineTabIndicator extends Decoration {
  /// 自定义下划线指示器
  const CustomUnderlineTabIndicator({
    this.width = 25,
    this.borderRadius,
    this.borderSide = const BorderSide(width: 2, color: Colors.white),
    this.insets = EdgeInsets.zero,
  });

  /// ### 指示器宽度
  ///
  /// 负数表示由内容决定
  final double? width;

  /// The radius of the indicator's corners.
  ///
  /// If this value is non-null, rounded rectangular tab indicator is
  /// drawn, otherwise rectangular tab indicator is drawn.
  final BorderRadius? borderRadius;

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide? borderSide;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the tab
  /// indicator's bounds in terms of its (centered) tab widget with
  /// [TabBarIndicatorSize.label], or the entire tab with
  /// [TabBarIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is CustomUnderlineTabIndicator) {
      return CustomUnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide!, borderSide!, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is CustomUnderlineTabIndicator) {
      return CustomUnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide!, b.borderSide!, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  /// 生命周期顶层（最先加载）
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, borderRadius, onChanged);
  }

  /// 指示器显示位置与长度
  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    if (width! < 0) {
      return Rect.fromLTWH(
        indicator.left,
        indicator.bottom - borderSide!.width,
        indicator.width,
        borderSide!.width,
      );
    }
    // 自定义宽度
    var cw = (indicator.left + indicator.right) / 2;
    return Rect.fromLTWH(
      cw - width! / 2,
      indicator.bottom - borderSide!.width,
      width!,
      borderSide!.width,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    if (borderRadius != null) {
      return Path()
        ..addRRect(
            borderRadius!.toRRect(_indicatorRectFor(rect, textDirection)));
    }
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(
    this.decoration,
    this.borderRadius,
    super.onChanged,
  );

  final CustomUnderlineTabIndicator decoration;
  final BorderRadius? borderRadius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Paint paint;
    if (borderRadius != null) {
      paint = Paint()..color = decoration.borderSide!.color;
      final Rect indicator = decoration._indicatorRectFor(rect, textDirection);
      final RRect rrect = RRect.fromRectAndCorners(
        indicator,
        topLeft: borderRadius!.topLeft,
        topRight: borderRadius!.topRight,
        bottomRight: borderRadius!.bottomRight,
        bottomLeft: borderRadius!.bottomLeft,
      );
      canvas.drawRRect(rrect, paint);
    } else {
      paint = decoration.borderSide!.toPaint()..strokeCap = StrokeCap.square;
      final Rect indicator = decoration
          ._indicatorRectFor(rect, textDirection)
          .deflate(decoration.borderSide!.width / 2.0);
      canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
    }
  }
}
