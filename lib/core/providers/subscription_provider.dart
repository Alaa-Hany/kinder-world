import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/app.dart';
import 'package:kinder_world/core/storage/secure_storage.dart';
import 'package:kinder_world/core/subscription/plan_info.dart';
import 'package:logger/logger.dart';

class SubscriptionState {
  final PlanTier currentTier;
  final bool isActive;
  final bool isProcessing;
  final String? error;
  final DateTime updatedAt;

  SubscriptionState({
    this.currentTier = PlanTier.free,
    this.isActive = false,
    this.isProcessing = false,
    this.error,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  SubscriptionState copyWith({
    PlanTier? currentTier,
    bool? isActive,
    bool? isProcessing,
    String? error,
    DateTime? updatedAt,
  }) {
    return SubscriptionState(
      currentTier: currentTier ?? this.currentTier,
      isActive: isActive ?? this.isActive,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubscriptionController extends StateNotifier<SubscriptionState> {
  final SecureStorage _storage;
  final Logger _logger;

  SubscriptionController({
    required SecureStorage storage,
    required Logger logger,
  })  : _storage = storage,
        _logger = logger,
        super(SubscriptionState()) {
    _load();
  }

  Future<void> _load() async {
    final tier = await _storage.getPlanTier() ?? PlanTier.free;
    final isActive = await _storage.hasActiveSubscription();
    state = state.copyWith(
      currentTier: tier,
      isActive: tier != PlanTier.free || isActive,
      updatedAt: DateTime.now(),
    );
  }

  Future<bool> activatePlan(PlanTier tier) async {
    state = state.copyWith(isProcessing: true, error: null);

    final savedTier = await _storage.savePlanTier(tier);
    final updatedActive =
        await _storage.setActiveSubscription(tier != PlanTier.free);

    final success = savedTier && updatedActive;
    if (!success) {
      state = state.copyWith(
        isProcessing: false,
        error: 'Unable to update subscription',
        updatedAt: DateTime.now(),
      );
      return false;
    }

    state = state.copyWith(
      currentTier: tier,
      isActive: tier != PlanTier.free,
      isProcessing: false,
      updatedAt: DateTime.now(),
    );
    _logger.d('Subscription tier updated: $tier');
    return true;
  }

  Future<bool> cancelSubscription() async {
    return await activatePlan(PlanTier.free);
  }
}

final subscriptionControllerProvider =
    StateNotifierProvider<SubscriptionController, SubscriptionState>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final logger = ref.watch(loggerProvider);
  return SubscriptionController(storage: storage, logger: logger);
});

final hasActiveSubscriptionProvider = Provider<bool>((ref) {
  return ref.watch(subscriptionControllerProvider).isActive;
});

final currentSubscriptionTierProvider = Provider<PlanTier>((ref) {
  return ref.watch(subscriptionControllerProvider).currentTier;
});
