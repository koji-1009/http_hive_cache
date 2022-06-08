import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cache_strategy.freezed.dart';

const _defaultDuration = Duration(days: 365);

/// Cache Configuration
@freezed
class CacheStrategy with _$CacheStrategy {
  /// Not cached
  const factory CacheStrategy.none() = _CacheStrategyNone;

  /// Cache control by client
  const factory CacheStrategy.client({
    @Default(_defaultDuration) Duration cacheControl,
  }) = _CacheStrategyClient;

  /// Cache control by header
  const factory CacheStrategy.server() = _CacheStrategyServer;
}
