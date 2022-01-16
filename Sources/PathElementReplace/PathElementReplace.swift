//
//  BuntingShape.swift
//  PathElementReplace
//
//  Copyright © 2022 Chris Davis, https://www.nthState.com
//
//  See https://github.com/nthState/PathElementReplace/blob/main/LICENSE for license information.
//

import SwiftUI

public extension Shape {
  
  /// Replace a Path.Element at index
  /// - Parameters:
  ///   - size: Size of the Path
  ///   - innerContent: The Path.Element to to replace if required
  /// - Returns: Shape
  func replace(size: CGRect, innerContent: @escaping (Int, Path.Element) -> Path.Element?) -> some Shape {
    PathElementReplace(shape: self, size: size, innerContent: innerContent)
  }
  
}

public struct PathElementReplace<S>: Shape where S: Shape {
  
  private let path: Path
  private let innerContent: (Int, Path.Element) -> Path.Element?
  
  public init(shape: S, size: CGRect, innerContent: @escaping (Int, Path.Element) -> Path.Element?) {
    self.path = shape.path(in: size)
    self.innerContent = innerContent
  }
  
  public func path(in rect: CGRect) -> Path {
    return generatePath()
  }
  
  /// For each path element we check to see if that element has been replaced by the user, otherwise, we use the existing element on the path
  /// - Returns: Path
  private func generatePath() -> Path {
    
    func add(element: Path.Element, to path: inout Path) {
      switch element {
      case .move(to: let to):
        path.move(to: to)
      case .line(to: let to):
        path.addLine(to: to)
      case .quadCurve(to: let to, control: let control):
        path.addQuadCurve(to: to, control: control)
      case .curve(to: let to, control1: let control1, control2: let control2):
        path.addCurve(to: to, control1: control1, control2: control2)
      case .closeSubpath:
        path.closeSubpath()
      }
    }
    
    return Path { path in
      
      var elementIndex: Int = 0
      self.path.forEach { element in
        let e = innerContent(elementIndex, element) ?? element
        add(element: e, to: &path)
        elementIndex += 1
      }
      
    }
  }
  
}
