// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cache_strategy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CacheStrategy {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(Duration cacheControl) client,
    required TResult Function() server,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(Duration cacheControl)? client,
    TResult? Function()? server,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(Duration cacheControl)? client,
    TResult Function()? server,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CacheStrategyNone value) none,
    required TResult Function(_CacheStrategyClient value) client,
    required TResult Function(_CacheStrategyServer value) server,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CacheStrategyNone value)? none,
    TResult? Function(_CacheStrategyClient value)? client,
    TResult? Function(_CacheStrategyServer value)? server,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CacheStrategyNone value)? none,
    TResult Function(_CacheStrategyClient value)? client,
    TResult Function(_CacheStrategyServer value)? server,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CacheStrategyCopyWith<$Res> {
  factory $CacheStrategyCopyWith(
          CacheStrategy value, $Res Function(CacheStrategy) then) =
      _$CacheStrategyCopyWithImpl<$Res, CacheStrategy>;
}

/// @nodoc
class _$CacheStrategyCopyWithImpl<$Res, $Val extends CacheStrategy>
    implements $CacheStrategyCopyWith<$Res> {
  _$CacheStrategyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_CacheStrategyNoneCopyWith<$Res> {
  factory _$$_CacheStrategyNoneCopyWith(_$_CacheStrategyNone value,
          $Res Function(_$_CacheStrategyNone) then) =
      __$$_CacheStrategyNoneCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_CacheStrategyNoneCopyWithImpl<$Res>
    extends _$CacheStrategyCopyWithImpl<$Res, _$_CacheStrategyNone>
    implements _$$_CacheStrategyNoneCopyWith<$Res> {
  __$$_CacheStrategyNoneCopyWithImpl(
      _$_CacheStrategyNone _value, $Res Function(_$_CacheStrategyNone) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_CacheStrategyNone
    with DiagnosticableTreeMixin
    implements _CacheStrategyNone {
  const _$_CacheStrategyNone();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CacheStrategy.none()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CacheStrategy.none'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_CacheStrategyNone);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(Duration cacheControl) client,
    required TResult Function() server,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(Duration cacheControl)? client,
    TResult? Function()? server,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(Duration cacheControl)? client,
    TResult Function()? server,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CacheStrategyNone value) none,
    required TResult Function(_CacheStrategyClient value) client,
    required TResult Function(_CacheStrategyServer value) server,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CacheStrategyNone value)? none,
    TResult? Function(_CacheStrategyClient value)? client,
    TResult? Function(_CacheStrategyServer value)? server,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CacheStrategyNone value)? none,
    TResult Function(_CacheStrategyClient value)? client,
    TResult Function(_CacheStrategyServer value)? server,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _CacheStrategyNone implements CacheStrategy {
  const factory _CacheStrategyNone() = _$_CacheStrategyNone;
}

/// @nodoc
abstract class _$$_CacheStrategyClientCopyWith<$Res> {
  factory _$$_CacheStrategyClientCopyWith(_$_CacheStrategyClient value,
          $Res Function(_$_CacheStrategyClient) then) =
      __$$_CacheStrategyClientCopyWithImpl<$Res>;
  @useResult
  $Res call({Duration cacheControl});
}

/// @nodoc
class __$$_CacheStrategyClientCopyWithImpl<$Res>
    extends _$CacheStrategyCopyWithImpl<$Res, _$_CacheStrategyClient>
    implements _$$_CacheStrategyClientCopyWith<$Res> {
  __$$_CacheStrategyClientCopyWithImpl(_$_CacheStrategyClient _value,
      $Res Function(_$_CacheStrategyClient) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacheControl = null,
  }) {
    return _then(_$_CacheStrategyClient(
      cacheControl: null == cacheControl
          ? _value.cacheControl
          : cacheControl // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$_CacheStrategyClient
    with DiagnosticableTreeMixin
    implements _CacheStrategyClient {
  const _$_CacheStrategyClient({this.cacheControl = _defaultDuration});

  @override
  @JsonKey()
  final Duration cacheControl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CacheStrategy.client(cacheControl: $cacheControl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CacheStrategy.client'))
      ..add(DiagnosticsProperty('cacheControl', cacheControl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CacheStrategyClient &&
            (identical(other.cacheControl, cacheControl) ||
                other.cacheControl == cacheControl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cacheControl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CacheStrategyClientCopyWith<_$_CacheStrategyClient> get copyWith =>
      __$$_CacheStrategyClientCopyWithImpl<_$_CacheStrategyClient>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(Duration cacheControl) client,
    required TResult Function() server,
  }) {
    return client(cacheControl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(Duration cacheControl)? client,
    TResult? Function()? server,
  }) {
    return client?.call(cacheControl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(Duration cacheControl)? client,
    TResult Function()? server,
    required TResult orElse(),
  }) {
    if (client != null) {
      return client(cacheControl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CacheStrategyNone value) none,
    required TResult Function(_CacheStrategyClient value) client,
    required TResult Function(_CacheStrategyServer value) server,
  }) {
    return client(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CacheStrategyNone value)? none,
    TResult? Function(_CacheStrategyClient value)? client,
    TResult? Function(_CacheStrategyServer value)? server,
  }) {
    return client?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CacheStrategyNone value)? none,
    TResult Function(_CacheStrategyClient value)? client,
    TResult Function(_CacheStrategyServer value)? server,
    required TResult orElse(),
  }) {
    if (client != null) {
      return client(this);
    }
    return orElse();
  }
}

abstract class _CacheStrategyClient implements CacheStrategy {
  const factory _CacheStrategyClient({final Duration cacheControl}) =
      _$_CacheStrategyClient;

  Duration get cacheControl;
  @JsonKey(ignore: true)
  _$$_CacheStrategyClientCopyWith<_$_CacheStrategyClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_CacheStrategyServerCopyWith<$Res> {
  factory _$$_CacheStrategyServerCopyWith(_$_CacheStrategyServer value,
          $Res Function(_$_CacheStrategyServer) then) =
      __$$_CacheStrategyServerCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_CacheStrategyServerCopyWithImpl<$Res>
    extends _$CacheStrategyCopyWithImpl<$Res, _$_CacheStrategyServer>
    implements _$$_CacheStrategyServerCopyWith<$Res> {
  __$$_CacheStrategyServerCopyWithImpl(_$_CacheStrategyServer _value,
      $Res Function(_$_CacheStrategyServer) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_CacheStrategyServer
    with DiagnosticableTreeMixin
    implements _CacheStrategyServer {
  const _$_CacheStrategyServer();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CacheStrategy.server()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CacheStrategy.server'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_CacheStrategyServer);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(Duration cacheControl) client,
    required TResult Function() server,
  }) {
    return server();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(Duration cacheControl)? client,
    TResult? Function()? server,
  }) {
    return server?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(Duration cacheControl)? client,
    TResult Function()? server,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CacheStrategyNone value) none,
    required TResult Function(_CacheStrategyClient value) client,
    required TResult Function(_CacheStrategyServer value) server,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CacheStrategyNone value)? none,
    TResult? Function(_CacheStrategyClient value)? client,
    TResult? Function(_CacheStrategyServer value)? server,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CacheStrategyNone value)? none,
    TResult Function(_CacheStrategyClient value)? client,
    TResult Function(_CacheStrategyServer value)? server,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class _CacheStrategyServer implements CacheStrategy {
  const factory _CacheStrategyServer() = _$_CacheStrategyServer;
}
