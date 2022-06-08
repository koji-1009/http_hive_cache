import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'cache_strategy.freezed.dart';

const _defaultDuration = Duration(days: 365);

@freezed
class CacheStrategy with _$CacheStrategy {
  const factory CacheStrategy.none() = _CacheStrategyNone;

  const factory CacheStrategy.client({
    @Default(_defaultDuration) Duration cacheControl,
  }) = _CacheStrategyClient;

  const factory CacheStrategy.server() = _CacheStrategyServer;
}
