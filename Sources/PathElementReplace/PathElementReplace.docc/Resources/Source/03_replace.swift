import SwiftUI
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
