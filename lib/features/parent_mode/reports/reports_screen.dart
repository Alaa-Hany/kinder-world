import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kinder_world/app.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/models/child_profile.dart';
import 'package:kinder_world/core/providers/child_session_controller.dart';
import 'package:kinder_world/core/theme/app_colors.dart';

enum ReportPeriod { week, month, year }

class _ActivitySegment {
  const _ActivitySegment({
    required this.value,
    required this.color,
    required this.label,
  });

  final double value;
  final Color color;
  final String label;
}

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({
    super.key,
    this.initialChildId,
  });

  final String? initialChildId;

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  ReportPeriod _period = ReportPeriod.week;
  ChildProfile? _selectedChild;

  String _periodLabel(AppLocalizations l10n) {
    switch (_period) {
      case ReportPeriod.week:
        return l10n.weeklyProgress;
      case ReportPeriod.month:
        return l10n.monthlyProgress;
      case ReportPeriod.year:
        return l10n.yearlyProgress;
    }
  }

  Map<String, String> _periodMetrics() {
    switch (_period) {
      case ReportPeriod.week:
        return {'activities': '25', 'score': '85%', 'time': '5.2h'};
      case ReportPeriod.month:
        return {'activities': '92', 'score': '88%', 'time': '21.4h'};
      case ReportPeriod.year:
        return {'activities': '480', 'score': '90%', 'time': '115h'};
    }
  }

  List<_ActivitySegment> _activitySegments(AppLocalizations l10n) {
    return [
      _ActivitySegment(
        value: 30,
        color: AppColors.educational,
        label: l10n.educationalContent,
      ),
      _ActivitySegment(
        value: 25,
        color: AppColors.entertaining,
        label: l10n.entertainment,
      ),
      _ActivitySegment(
        value: 25,
        color: AppColors.skillful,
        label: l10n.skillfulActivities,
      ),
      _ActivitySegment(
        value: 20,
        color: AppColors.behavioral,
        label: l10n.behavioralSkills,
      ),
    ];
  }

  void _showChildSelection(List<ChildProfile> children) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: children.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final child = children[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                  child: Text(
                    child.name.isNotEmpty ? child.name[0] : '?',
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
                title: Text(child.name),
                subtitle: Text('Age ${child.age} - Level ${child.level}'),
                trailing: _selectedChild?.id == child.id
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedChild = child;
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.reportsAndAnalytics),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: FutureBuilder<String?>(
          future: ref.read(secureStorageProvider).getParentId(),
          builder: (context, parentIdSnapshot) {
            final parentId = parentIdSnapshot.data ?? '';
            return FutureBuilder<List<ChildProfile>>(
              future: ref
                  .read(childRepositoryProvider)
                  .getChildProfilesForParent(parentId),
              builder: (context, childrenSnapshot) {
                if (childrenSnapshot.connectionState == ConnectionState.waiting &&
                    childrenSnapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                final children = childrenSnapshot.data ?? [];

                if (_selectedChild == null && children.isNotEmpty) {
                  final initialChild = widget.initialChildId != null
                      ? children.firstWhere(
                          (child) => child.id == widget.initialChildId,
                          orElse: () => children.first,
                        )
                      : children.first;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    setState(() {
                      _selectedChild = initialChild;
                    });
                  });
                }

                final selectedChild =
                    _selectedChild ?? (children.isNotEmpty ? children.first : null);
                final metrics = _periodMetrics();

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        l10n.learningProgressReports,
                        style: const TextStyle(
                          fontSize: AppConstants.largeFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.trackChildDevelopment,
                        style: const TextStyle(
                          fontSize: AppConstants.fontSize,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Child Selection
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  selectedChild?.name.isNotEmpty == true
                                      ? selectedChild!.name[0]
                                      : '?',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedChild?.name ?? l10n.noChildSelected,
                                    style: const TextStyle(
                                      fontSize: AppConstants.fontSize,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    selectedChild != null
                                        ? '${l10n.childAge} ${selectedChild.age} - ${l10n.level} ${selectedChild.level}'
                                        : l10n.addChildToViewReports,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              onPressed: children.isEmpty
                                  ? null
                                  : () => _showChildSelection(children),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Time Period Selection
                      Row(
                        children: [
                          _buildPeriodButton(l10n.week, ReportPeriod.week),
                          const SizedBox(width: 8),
                          _buildPeriodButton(l10n.month, ReportPeriod.month),
                          const SizedBox(width: 8),
                          _buildPeriodButton(l10n.year, ReportPeriod.year),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Progress Overview
                      _buildProgressOverview(
                        _periodLabel(l10n),
                        metrics['activities'] ?? '-',
                        metrics['score'] ?? '-',
                        metrics['time'] ?? '-',
                      ),
                      const SizedBox(height: 24),

                      // Activity Breakdown Chart
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.activityBreakdown,
                              style: const TextStyle(
                                fontSize: AppConstants.fontSize,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 180,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final size = Size(
                                    constraints.maxWidth,
                                    constraints.maxHeight,
                                  );
                                  final double chartRadius = math.max(
                                    0.0,
                                    (math.min(size.width, size.height) / 2) - 14.0,
                                  );
                                  final double centerSpaceRadius =
                                      chartRadius * 0.6;
                                  final double labelRadius = math.max(
                                    0.0,
                                    centerSpaceRadius +
                                        ((chartRadius - centerSpaceRadius) / 2),
                                  );
                                  final segments = _activitySegments(l10n);
                                  final textDirection = Directionality.of(context);

                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      PieChart(
                                        PieChartData(
                                          startDegreeOffset: -90,
                                          centerSpaceRadius: centerSpaceRadius,
                                          sectionsSpace: 2,
                                          sections: segments
                                              .map(
                                                (segment) => PieChartSectionData(
                                                  value: segment.value,
                                                  color: segment.color,
                                                  radius: chartRadius,
                                                  showTitle: false,
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                      CustomPaint(
                                        size: size,
                                        painter: _ArcTextPainter(
                                          segments: segments,
                                          radius: labelRadius,
                                          textDirection: textDirection,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Recent Achievements
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.recentAchievements,
                              style: const TextStyle(
                                fontSize: AppConstants.fontSize,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildAchievementItem(
                              '*',
                              'Math Master',
                              'Completed 10 math activities',
                              '2 ${l10n.daysAgo}',
                            ),
                            const SizedBox(height: 12),
                            _buildAchievementItem(
                              '!',
                              'Perfect Score',
                              'Got 100% in Science Quiz',
                              '3 ${l10n.daysAgo}',
                            ),
                            const SizedBox(height: 12),
                            _buildAchievementItem(
                              '+',
                              '5-Day Streak',
                              'Used app for 5 consecutive days',
                              l10n.justNow,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String text, ReportPeriod period) {
    final isSelected = _period == period;
    return InkWell(
      onTap: () {
        setState(() {
          _period = period;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressOverview(
    String title,
    String activities,
    String score,
    String time,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppConstants.fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProgressMetric(
                'Activities',
                activities,
                AppColors.success,
                Icons.check_circle,
              ),
              _buildProgressMetric(
                'Avg Score',
                score,
                AppColors.xpColor,
                Icons.star,
              ),
              _buildProgressMetric(
                'Time',
                time,
                AppColors.info,
                Icons.timer,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressMetric(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 25,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementItem(
    String emoji,
    String title,
    String description,
    String time,
  ) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

}

class _ArcTextPainter extends CustomPainter {
  _ArcTextPainter({
    required this.segments,
    required this.radius,
    required this.textDirection,
  });

  final List<_ActivitySegment> segments;
  final double radius;
  final TextDirection textDirection;

  static const double _baseFontSize = 10;
  static const double _sliceWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius <= 0) return;

    final total = segments.fold<double>(0, (sum, segment) => sum + segment.value);
    if (total <= 0) return;

    final center = size.center(Offset.zero);
    var startAngle = -math.pi / 2;

    for (final segment in segments) {
      final sweepAngle = (segment.value / total) * math.pi * 2;
      if (sweepAngle == 0) {
        startAngle += sweepAngle;
        continue;
      }
      _paintCurvedLabel(
        canvas: canvas,
        center: center,
        radius: radius,
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        text: segment.label,
      );
      startAngle += sweepAngle;
    }
  }

  void _paintCurvedLabel({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required double startAngle,
    required double sweepAngle,
    required String text,
  }) {
    final baseStyle = const TextStyle(
      color: AppColors.white,
      fontSize: _baseFontSize,
      fontWeight: FontWeight.w600,
    );

    var painter = TextPainter(
      text: TextSpan(text: text, style: baseStyle),
      textDirection: textDirection,
      textAlign: TextAlign.center,
      maxLines: 1,
    )..layout();

    if (painter.width == 0) return;

    final arcLength = radius * sweepAngle.abs();
    final scale = arcLength > 0 ? math.min(1.0, arcLength / painter.width) : 1.0;
    if (scale < 1.0) {
      painter = TextPainter(
        text: TextSpan(
          text: text,
          style: baseStyle.copyWith(fontSize: _baseFontSize * scale),
        ),
        textDirection: textDirection,
        textAlign: TextAlign.center,
        maxLines: 1,
      )..layout();
    }

    final metrics = painter.computeLineMetrics();
    final baseline = metrics.isNotEmpty ? metrics.first.baseline : painter.height;
    final textWidth = painter.width;
    final textHeight = painter.height;
    final centerAngle = startAngle + (sweepAngle / 2);
    final flip = _shouldFlip(centerAngle);
    final isRtl = textDirection == TextDirection.rtl;

    final directionSweep = flip ? -sweepAngle : sweepAngle;
    final maxLabelSweep = directionSweep.abs();
    final labelSweep = radius > 0 ? textWidth / radius : 0;
    final usedSweep = math.min(maxLabelSweep, labelSweep);
    final finalSweep = usedSweep * (directionSweep.isNegative ? -1 : 1);
    final labelStart = centerAngle - (finalSweep / 2);

    final sliceCount = math.max(1, (textWidth / _sliceWidth).ceil());
    final actualSliceWidth = textWidth / sliceCount;
    final paintOffset = Offset(-textWidth / 2, -baseline);

    for (var i = 0; i < sliceCount; i++) {
      final sliceCenter = (i + 0.5) * actualSliceWidth;
      final x = isRtl ? textWidth - sliceCenter : sliceCenter;
      final t = isRtl ? 1 - (sliceCenter / textWidth) : (sliceCenter / textWidth);
      final angle = labelStart + (finalSweep * t);
      final rotation = angle + math.pi / 2 + (flip ? math.pi : 0);

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.translate(radius * math.cos(angle), radius * math.sin(angle));
      canvas.rotate(rotation);
      canvas.clipRect(
        Rect.fromLTWH(
          paintOffset.dx + x - (actualSliceWidth / 2),
          paintOffset.dy,
          actualSliceWidth,
          textHeight,
        ),
      );
      painter.paint(canvas, paintOffset);
      canvas.restore();
    }
  }

  bool _shouldFlip(double angle) {
    final normalized = (angle + (math.pi * 2)) % (math.pi * 2);
    return normalized > math.pi / 2 && normalized < math.pi * 1.5;
  }

  @override
  bool shouldRepaint(covariant _ArcTextPainter oldDelegate) {
    return oldDelegate.segments != segments ||
        oldDelegate.radius != radius ||
        oldDelegate.textDirection != textDirection;
  }
}
