/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// @generated by enums.py
// clang-format off
#pragma once

#include <cstdint>
#include "YGEnums.h"
#include "Enums_YogaEnums.h"

namespace facebook::yoga {

enum class Gutter : uint8_t {
  Column = YGGutterColumn,
  Row = YGGutterRow,
  All = YGGutterAll,
};

template <>
constexpr int32_t ordinalCount<Gutter>() {
  return 3;
}

constexpr Gutter scopedEnum(YGGutter unscoped) {
  return static_cast<Gutter>(unscoped);
}

constexpr YGGutter unscopedEnum(Gutter scoped) {
  return static_cast<YGGutter>(scoped);
}

inline const char* toString(Gutter e) {
  return YGGutterToString(unscopedEnum(e));
}

} // namespace facebook::yoga
