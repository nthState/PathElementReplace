# Chris's SwiftUI Path Element Replace

Given a Shape, Replace any Element with another Element, or set of Elements

## Overview

```
import PathElementReplace

struct ExampleSwiftUIView {}

extension ExampleSwiftUIView: View {
  
  var body: some View {
    content
  }
  
  var content: some View {
    Rectangle()
      .replace(size: CGRect(origin: .zero, size: CGSize(width: 100, height: 100))) { index, element in
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

```

| Before | After |
|--------|-------|
![Before](Sources/PathElementReplace/PathElementReplace.docc/Resources/Images/01_replace.png)|![After](Sources/PathElementReplace/PathElementReplace.docc/Resources/Images/03_replace.png)

