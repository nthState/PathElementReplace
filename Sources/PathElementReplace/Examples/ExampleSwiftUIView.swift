//
//  BuntingShape.swift
//  PathElementReplace
//
//  Copyright © 2022 Chris Davis, https://www.nthState.com
//
//  See https://github.com/nthState/PathElementReplace/blob/main/LICENSE for license information.
//

import SwiftUI

struct ExampleSwiftUIView {}

extension ExampleSwiftUIView: View {
  
  var body: some View {
    VStack(spacing: 24) {
      shape
      shapeWithReplacement
    }
  }
  
  var shape: some View {
    Rectangle()
      .stroke(Color.red, lineWidth: 2)
      .frame(width: 100, height: 100)
  }
  
  var shapeWithReplacement: some View {
    Rectangle()
      .replace { index, element in
        if index == 1 {
          return Path.Element.line(to: CGPoint(x: 200, y: 50))
        } else {
          return nil
        }
      }
      .stroke(Color.red, lineWidth: 2)
      .frame(width: 100, height: 100)
  }
  
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    ExampleSwiftUIView()
  }
}
