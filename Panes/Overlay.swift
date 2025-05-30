// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUI

struct Overlay: View {
  @Binding var layout: PaneLayout
  @State var url: String = "Overlay"

  var body: some View {
    TextField("URL", text: $url)
      .textFieldStyle(CustomTextFieldStyle())
      .padding()
      .frame(minWidth: 100, maxWidth: 1000)
      .background(
        Rectangle()
          .fill(Color.gray.opacity(0.2))
          .cornerRadius(8)
          .padding(.horizontal)
      )
  }
}

struct CustomTextFieldStyle: TextFieldStyle {
  func _body(configuration: TextField<_Label>) -> some View {
    configuration
      .padding(.horizontal)
      .font(.title)
      .backgroundStyle(.clear)
  }
}

#Preview {
  @Previewable @State var layout: PaneLayout = .horizontal([
    .single,
    .vertical([.single, .single]),
  ])

  VStack {
    Overlay(layout: $layout)
  }
  .frame(width: 640, height: 480)
}
