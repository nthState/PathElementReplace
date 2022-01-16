//
//  CGRect+.swift
//  PathElementReplace
//
//  Copyright © 2022 Chris Davis, https://www.nthState.com
//
//  See https://github.com/nthState/PathElementReplace/blob/master/LICENSE for license information.
//

import CoreGraphics

internal extension CGRect {
  
  /// Creates a unit CGRect of size: 1x1
  static var unit: CGRect {
    CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
  }
  
}
