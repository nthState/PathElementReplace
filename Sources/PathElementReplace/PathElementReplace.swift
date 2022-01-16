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
  
  func replace(innerContent: @escaping (Int, Path.Element) -> Path.Element?) -> some Shape {
    PathElementReplace(shape: self, innerContent: innerContent)
  }
  
}

public struct PathElementReplace<S>: Shape where S: Shape {
  
  private let path: Path
  private let innerContent: (Int, Path.Element) -> Path.Element?
  
  public init(shape: S, innerContent: @escaping (Int, Path.Element) -> Path.Element?) {
    
    self.path = shape.path(in: CGRect.unit)
    self.innerContent = innerContent
  }
  
  public func path(in rect: CGRect) -> Path {
    return generatePath()
  }
  
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
      
      var counter: Int = 0
      self.path.forEach { element in
        let e = innerContent(counter, element) ?? element
        add(element: e, to: &path)
        counter += 1
      }
      
    }
  }
  
}
