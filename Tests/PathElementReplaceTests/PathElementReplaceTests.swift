//
//  PathElementReplaceTests.swift
//  PathElementReplace
//
//  Copyright © 2022 Chris Davis, https://www.nthState.com
//
//  See https://github.com/nthState/PathElementReplace/blob/main/LICENSE for license information.
//

import XCTest
import SwiftUI
@testable import PathElementReplace

final class PathElementReplaceTests: XCTestCase {
  
    func test_no_paths_replaced() throws {
        
      let rect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
      let shape = Rectangle()
      
      let newShape = PathElementReplace(shape: shape, size: rect) { index, element in
        return nil
      }
      
      XCTAssertEqual(shape.path(in: rect).description, newShape.path(in: rect).description, "Shape should match")
    }
  
  func test_paths_replaced_not_equal() throws {
      
    let rect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
    let shape = Rectangle()
    
    let newShape = PathElementReplace(shape: shape, size: rect) { index, element in
      if index == 1 {
        return Path.Element.line(to: CGPoint(x: 200, y: 50))
      } else {
        return nil
      }
    }
    
    XCTAssertNotEqual(shape.path(in: rect).description, newShape.path(in: rect).description, "Shape shouldn't match")
  }
  
}
