import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/app.dart';
import 'package:kinder_world/core/subscription/plan_info.dart';

final planInfoProvider = FutureProvider<PlanInfo>((ref) async {
  final storage = ref.watch(secureStorageProvider);
  final storedTier = await storage.getPlanTier();

  if (storedTier != null) {
    return PlanInfo.fromTier(storedTier);
  }

  final hasSubscription = await storage.hasActiveSubscription();
  final tier = hasSubscription ? PlanTier.premium : PlanTier.free;
  return PlanInfo.fromTier(tier);
});
