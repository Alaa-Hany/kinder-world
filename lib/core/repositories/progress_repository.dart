import 'dart:async';
import 'package:hive/hive.dart';
import 'package:kinder_world/core/models/progress_record.dart';
import 'package:logger/logger.dart';

/// Repository for progress tracking
/// Manages XP, levels, streaks, and activity completion records
/// Stores data as JSON maps since Freezed models don't support Hive TypeAdapters
class ProgressRepository {
  final Box _progressBox;
  final Logger _logger;

  ProgressRepository({
    required Box progressBox,
    required Logger logger,
  })  : _progressBox = progressBox,
        _logger = logger;

  // Helper methods for JSON serialization
  ProgressRecord? _getProgressFromBox(String recordId) {
    final data = _progressBox.get(recordId);
    if (data == null) return null;
    try {
      final map = data as Map<String, dynamic>;
      return ProgressRecord.fromJson(map);
    } catch (e) {
      _logger.e('Error deserializing progress record: $recordId, $e');
      return null;
    }
  }

  Future<void> _saveProgressToBox(String recordId, ProgressRecord record) async {
    await _progressBox.put(recordId, record.toJson());
  }

  List<ProgressRecord> _getAllProgressFromBox() {
    try {
      return _progressBox.values
          .map((data) {
            try {
              final map = data as Map<String, dynamic>;
              return ProgressRecord.fromJson(map);
            } catch (e) {
              _logger.e('Error deserializing progress record from box: $e');
              return null;
            }
          })
          .whereType<ProgressRecord>()
          .toList();
    } catch (e) {
      _logger.e('Error getting all progress records from box: $e');
      return [];
    }
  }

  // ==================== PROGRESS RECORDS ====================

  /// Create progress record for completed activity
  Future<ProgressRecord?> createProgressRecord({
    required String childId,
    required String activityId,
    required int score,
    required int duration,
    required int xpEarned,
    String? notes,
    String completionStatus = CompletionStatus.completed,
    Map<String, dynamic>? performanceMetrics,
    String? aiFeedback,
    String? moodBefore,
    String? moodAfter,
    bool? difficultyAdjusted,
    bool? helpRequested,
    bool? parentApproved,
  }) async {
    try {
      _logger.d('Creating progress record for child: $childId, activity: $activityId');
      
      final recordId = 'progress_${DateTime.now().millisecondsSinceEpoch}';
      
      final record = ProgressRecord(
        id: recordId,
        childId: childId,
        activityId: activityId,
        date: DateTime.now(),
        score: score,
        duration: duration,
        xpEarned: xpEarned,
        notes: notes,
        completionStatus: completionStatus,
        performanceMetrics: performanceMetrics,
        aiFeedback: aiFeedback,
        moodBefore: moodBefore,
        moodAfter: moodAfter,
        difficultyAdjusted: difficultyAdjusted,
        helpRequested: helpRequested,
        parentApproved: parentApproved,
        syncStatus: SyncStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _saveProgressToBox(recordId, record);
      _logger.d('Progress record created: $recordId');
      return record;
    } catch (e, stack) {
      _logger.e('Error creating progress record: $e');
      return null;
    }
  }

  /// Get progress record by ID
  Future<ProgressRecord?> getProgressRecord(String recordId) async {
    try {
      return _getProgressFromBox(recordId);
    } catch (e, stack) {
      _logger.e('Error getting progress record: $recordId, $e');
      return null;
    }
  }

  /// Get all progress records for a child
  Future<List<ProgressRecord>> getProgressForChild(String childId) async {
    try {
      final records = _getAllProgressFromBox()
          .where((record) => record.childId == childId)
          .toList();
      records.sort((a, b) => b.date.compareTo(a.date));
      return records;
    } catch (e, stack) {
      _logger.e('Error getting progress for child: $childId, $e');
      return [];
    }
  }

  /// Get progress records for specific activity
  Future<List<ProgressRecord>> getProgressForActivity(String activityId) async {
    try {
      final records = _getAllProgressFromBox()
          .where((record) => record.activityId == activityId)
          .toList();
      records.sort((a, b) => b.date.compareTo(a.date));
      return records;
    } catch (e, stack) {
      _logger.e('Error getting progress for activity: $activityId, $e');
      return [];
    }
  }

  /// Get progress records for date range
  Future<List<ProgressRecord>> getProgressForDateRange({
    required String childId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final records = _getAllProgressFromBox()
          .where((record) => 
              record.childId == childId &&
              record.date.isAfter(startDate) &&
              record.date.isBefore(endDate))
          .toList();
      records.sort((a, b) => b.date.compareTo(a.date));
      return records;
    } catch (e, stack) {
      _logger.e('Error getting progress for date range: $e');
      return [];
    }
  }

  /// Get today's progress
  Future<List<ProgressRecord>> getTodayProgress(String childId) async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      
      return _getAllProgressFromBox()
          .where((record) => 
              record.childId == childId &&
              record.date.isAfter(startOfDay) &&
              record.date.isBefore(endOfDay))
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting today\'s progress for child: $childId, $e');
      return [];
    }
  }

  // ==================== STATISTICS ====================

  /// Get child statistics
  Future<Map<String, dynamic>> getChildStats(String childId) async {
    try {
      final records = await getProgressForChild(childId);
      
      if (records.isEmpty) {
        return {
          'totalActivities': 0,
          'totalXP': 0,
          'totalTime': 0,
          'averageScore': 0,
          'completionRate': 0,
          'favoriteCategory': null,
          'streakDays': 0,
          'lastActivity': null,
        };
      }
      
      // Calculate totals
      final totalActivities = records.length;
      final totalXP = records.fold(0, (sum, record) => sum + record.xpEarned);
      final totalTime = records.fold(0, (sum, record) => sum + record.duration);
      final totalScore = records.fold(0, (sum, record) => sum + record.score);
      final averageScore = totalScore / totalActivities;
      
      // Calculate completion rate
      final completed = records.where((r) => r.completionStatus == CompletionStatus.completed).length;
      final completionRate = completed / totalActivities * 100;
      
      // Find favorite category (would need activity data)
      String? favoriteCategory;
      
      // Calculate streak
      final streakDays = await calculateStreakDays(records);
      
      // Last activity
      final lastActivity = records.isNotEmpty ? records.first.date : null;
      
      return {
        'totalActivities': totalActivities,
        'totalXP': totalXP,
        'totalTime': totalTime,
        'averageScore': averageScore,
        'completionRate': completionRate,
        'favoriteCategory': favoriteCategory,
        'streakDays': streakDays,
        'lastActivity': lastActivity,
      };
    } catch (e, stack) {
      _logger.e('Error getting child stats: $childId, $e');
      return {};
    }
  }

  /// Calculate streak days from progress records
  Future<int> calculateStreakDays(List<ProgressRecord> records) async {
    if (records.isEmpty) return 0;
    
    // Group by date
    final datesByDay = <DateTime, List<ProgressRecord>>{};
    
    for (final record in records) {
      final day = DateTime(record.date.year, record.date.month, record.date.day);
      datesByDay.putIfAbsent(day, () => []).add(record);
    }
    
    final uniqueDays = datesByDay.keys.toList()..sort();
    if (uniqueDays.isEmpty) return 0;
    
    // Calculate consecutive days from today
    final today = DateTime.now();
    int streak = 0;
    DateTime? lastDay;
    
    for (int i = uniqueDays.length - 1; i >= 0; i--) {
      final day = uniqueDays[i];
      
      if (lastDay == null) {
        // First day in streak
        final daysDiff = today.difference(day).inDays;
        if (daysDiff <= 1) {
          streak = 1;
          lastDay = day;
        } else {
          break;
        }
      } else {
        // Check if consecutive
        final daysDiff = lastDay!.difference(day).inDays;
        if (daysDiff == 1) {
          streak++;
          lastDay = day;
        } else {
          break;
        }
      }
    }
    
    return streak;
  }

  /// Get weekly progress summary
  Future<Map<String, dynamic>> getWeeklySummary(String childId) async {
    try {
      final now = DateTime.now();
      final weekAgo = now.subtract(const Duration(days: 7));
      
      final records = await getProgressForDateRange(
        childId: childId,
        startDate: weekAgo,
        endDate: now,
      );
      
      // Group by day
      final dailyProgress = <String, List<ProgressRecord>>{};
      
      for (final record in records) {
        final dayKey = '${record.date.year}-${record.date.month}-${record.date.day}';
        dailyProgress.putIfAbsent(dayKey, () => []).add(record);
      }
      
      // Calculate daily stats
      final dailyStats = dailyProgress.map((day, dayRecords) {
        final totalXP = dayRecords.fold(0, (sum, r) => sum + r.xpEarned);
        final totalTime = dayRecords.fold(0, (sum, r) => sum + r.duration);
        final completed = dayRecords.where((r) => r.completionStatus == CompletionStatus.completed).length;
        
        return MapEntry(day, {
          'activities': dayRecords.length,
          'xp': totalXP,
          'time': totalTime,
          'completed': completed,
        });
      });
      
      return {
        'dailyStats': dailyStats,
        'totalActivities': records.length,
        'totalXP': records.fold(0, (sum, r) => sum + r.xpEarned),
        'totalTime': records.fold(0, (sum, r) => sum + r.duration),
      };
    } catch (e, stack) {
      _logger.e('Error getting weekly summary for child: $childId, $e');
      return {};
    }
  }

  /// Get monthly progress summary
  Future<Map<String, dynamic>> getMonthlySummary(String childId) async {
    try {
      final now = DateTime.now();
      final monthAgo = now.subtract(const Duration(days: 30));
      
      final records = await getProgressForDateRange(
        childId: childId,
        startDate: monthAgo,
        endDate: now,
      );
      
      // Group by week
      final weeklyProgress = <int, List<ProgressRecord>>{};
      
      for (final record in records) {
        final week = ((now.difference(record.date).inDays) / 7).floor();
        weeklyProgress.putIfAbsent(week, () => []).add(record);
      }
      
      // Calculate weekly stats
      final weeklyStats = weeklyProgress.map((week, weekRecords) {
        final totalXP = weekRecords.fold(0, (sum, r) => sum + r.xpEarned);
        final totalTime = weekRecords.fold(0, (sum, r) => sum + r.duration);
        
        return MapEntry(week, {
          'activities': weekRecords.length,
          'xp': totalXP,
          'time': totalTime,
        });
      });
      
      return {
        'weeklyStats': weeklyStats,
        'totalActivities': records.length,
        'totalXP': records.fold(0, (sum, r) => sum + r.xpEarned),
        'totalTime': records.fold(0, (sum, r) => sum + r.duration),
      };
    } catch (e, stack) {
      _logger.e('Error getting monthly summary for child: $childId, $e');
      return {};
    }
  }

  // ==================== PERFORMANCE ANALYTICS ====================

  /// Get performance trends
  Future<Map<String, dynamic>> getPerformanceTrends(String childId) async {
    try {
      final records = await getProgressForChild(childId);
      
      if (records.isEmpty) {
        return {
          'improvement': 0,
          'trend': 'stable',
          'strongestArea': null,
          'needsWork': null,
        };
      }
      
      // Group by category (would need activity data)
      final recentRecords = records.take(10).toList();
      final olderRecords = records.skip(10).take(10).toList();
      
      double recentAverage = 0;
      double olderAverage = 0;
      
      if (recentRecords.isNotEmpty) {
        recentAverage = recentRecords.fold(0, (sum, r) => sum + r.score) / recentRecords.length;
      }
      
      if (olderRecords.isNotEmpty) {
        olderAverage = olderRecords.fold(0, (sum, r) => sum + r.score) / olderRecords.length;
      }
      
      final improvement = recentAverage - olderAverage;
      String trend;
      
      if (improvement > 5) {
        trend = 'improving';
      } else if (improvement < -5) {
        trend = 'declining';
      } else {
        trend = 'stable';
      }
      
      return {
        'improvement': improvement,
        'trend': trend,
        'recentAverage': recentAverage,
        'olderAverage': olderAverage,
      };
    } catch (e, stack) {
      _logger.e('Error getting performance trends for child: $childId, $e');
      return {};
    }
  }

  /// Get mood analysis
  Future<Map<String, dynamic>> getMoodAnalysis(String childId) async {
    try {
      final records = await getProgressForChild(childId);
      
      final moodBeforeCounts = <String, int>{};
      final moodAfterCounts = <String, int>{};
      int moodImprovements = 0;
      
      for (final record in records) {
        if (record.moodBefore != null) {
          moodBeforeCounts[record.moodBefore!] = 
              (moodBeforeCounts[record.moodBefore!] ?? 0) + 1;
        }
        
        if (record.moodAfter != null) {
          moodAfterCounts[record.moodAfter!] = 
              (moodAfterCounts[record.moodAfter!] ?? 0) + 1;
        }
        
        if (record.moodImproved) {
          moodImprovements++;
        }
      }
      
      final totalRecords = records.length;
      final improvementRate = totalRecords > 0 ? moodImprovements / totalRecords * 100 : 0;
      
      return {
        'moodBeforeCounts': moodBeforeCounts,
        'moodAfterCounts': moodAfterCounts,
        'moodImprovementRate': improvementRate,
        'mostCommonBefore': _getMostCommonMood(moodBeforeCounts),
        'mostCommonAfter': _getMostCommonMood(moodAfterCounts),
      };
    } catch (e, stack) {
      _logger.e('Error getting mood analysis for child: $childId, $e');
      return {};
    }
  }

  String? _getMostCommonMood(Map<String, int> moodCounts) {
    if (moodCounts.isEmpty) return null;
    
    String? mostCommon;
    int maxCount = 0;
    
    moodCounts.forEach((mood, count) {
      if (count > maxCount) {
        maxCount = count;
        mostCommon = mood;
      }
    });
    
    return mostCommon;
  }

  // ==================== SYNC OPERATIONS ====================

  /// Get records that need sync
  Future<List<ProgressRecord>> getRecordsNeedingSync() async {
    try {
      return _getAllProgressFromBox()
          .where((record) => record.needsSync)
          .toList();
    } catch (e, stack) {
      _logger.e('Error getting records needing sync: $e');
      return [];
    }
  }

  /// Mark record as synced
  Future<bool> markAsSynced(String recordId) async {
    try {
      final record = _getProgressFromBox(recordId);
      if (record == null) return false;
      
      final updated = record.copyWith(
        syncStatus: SyncStatus.synced,
        updatedAt: DateTime.now(),
      );
      
      await _saveProgressToBox(recordId, updated);
      return true;
    } catch (e, stack) {
      _logger.e('Error marking record as synced: $recordId, $e');
      return false;
    }
  }

  /// Sync with server (placeholder)
  Future<bool> syncWithServer() async {
    try {
      _logger.d('Syncing progress with server');
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      return true;
    } catch (e, stack) {
      _logger.e('Error syncing progress with server: $e');
      return false;
    }
  }
}