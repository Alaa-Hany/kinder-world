import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/providers/plan_provider.dart';
import 'package:kinder_world/core/subscription/plan_info.dart';
import 'package:kinder_world/core/theme/app_colors.dart';

class PlanGuard extends ConsumerWidget {
  final PlanTier requiredTier;
  final Widget child;
  final String? featureLabel;
  final EdgeInsetsGeometry padding;

  const PlanGuard({
    super.key,
    required this.requiredTier,
    required this.child,
    this.featureLabel,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(planInfoProvider);
    return planAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (_, __) => child,
      data: (plan) {
        if (plan.canAccess(requiredTier)) {
          return child;
        }
        return Padding(
          padding: padding,
          child: PlanUpgradeCard(
            plan: plan,
            requiredTier: requiredTier,
            featureLabel: featureLabel,
          ),
        );
      },
    );
  }
}

class PlanUpgradeCard extends StatelessWidget {
  final PlanInfo plan;
  final PlanTier requiredTier;
  final String? featureLabel;

  const PlanUpgradeCard({
    super.key,
    required this.plan,
    required this.requiredTier,
    this.featureLabel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final featureList = _featureList(l10n, requiredTier);
    final planName = _planName(l10n, plan.tier);
    final planDetails = _planDetails(l10n, plan);
    final ctaLabel =
        requiredTier == PlanTier.familyPlus ? l10n.choosePlan : l10n.upgradeNow;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.lock, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.planFeatureInPremium,
                      style: const TextStyle(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (featureLabel != null && featureLabel!.isNotEmpty)
                      Text(
                        featureLabel!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
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
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        planName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: planDetails.map((detail) {
                          return _DetailChip(label: detail);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.premiumFeatures,
            style: const TextStyle(
              fontSize: AppConstants.fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          ...featureList.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      size: 18, color: AppColors.success),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => context.push('/parent/subscription'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                ctaLabel,
                style: const TextStyle(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _featureList(AppLocalizations l10n, PlanTier tier) {
    switch (tier) {
      case PlanTier.familyPlus:
        return [
          l10n.planAiInsightsPro,
          l10n.planAdvancedReports,
          l10n.planOfflineDownloads,
          l10n.planSmartControls,
          l10n.planExclusiveContent,
          l10n.planFamilyDashboard,
          l10n.planUnlimitedChildren,
        ];
      case PlanTier.premium:
        return [
          l10n.planAiInsightsPro,
          l10n.planAdvancedReports,
          l10n.planOfflineDownloads,
          l10n.planSmartControls,
          l10n.planExclusiveContent,
        ];
      case PlanTier.free:
        return [
          l10n.planBasicReports,
        ];
    }
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

class _DetailChip extends StatelessWidget {
  final String label;

  const _DetailChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
