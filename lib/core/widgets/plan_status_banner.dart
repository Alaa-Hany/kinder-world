import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/providers/plan_provider.dart';
import 'package:kinder_world/core/subscription/plan_info.dart';
import 'package:kinder_world/core/theme/app_colors.dart';

class PlanStatusBanner extends ConsumerWidget {
  final EdgeInsetsGeometry margin;

  const PlanStatusBanner({
    super.key,
    this.margin = const EdgeInsets.only(bottom: 16),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final planAsync = ref.watch(planInfoProvider);

    return planAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (plan) {
        final planName = _planName(l10n, plan.tier);
        final details = _planDetails(l10n, plan);
        return Container(
          margin: margin,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.lightGrey),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.stars,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.currentPlan,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          planName,
                          style: const TextStyle(
                            fontSize: AppConstants.fontSize,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: details.map((detail) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      detail,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  String _planName(AppLocalizations l10n, PlanTier tier) {
    switch (tier) {
      case PlanTier.free:
        return l10n.planFree;
      case PlanTier.premium:
        return l10n.planPremium;
      case PlanTier.familyPlus:
        return l10n.planFamilyPlus;
    }
  }

  List<String> _planDetails(AppLocalizations l10n, PlanInfo plan) {
    final details = <String>[
      plan.isUnlimitedChildren
          ? l10n.planUnlimitedChildren
          : l10n.planChildLimit(plan.maxChildren),
      plan.hasAdvancedReports ? l10n.planAdvancedReports : l10n.planBasicReports,
    ];
    if (plan.hasAiInsights) {
      details.add(l10n.planAiInsightsPro);
    }
    if (plan.hasFamilyDashboard) {
      details.add(l10n.planFamilyDashboard);
    }
    return details;
  }
}
