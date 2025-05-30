// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUI

struct Overlay: View {
  @Binding var layout: PaneLayout
  @EnvironmentObject var nav: NavigationState
  @State var url: String

  var body: some View {
    TextField("URL", text: $url)
      .onSubmit(handleSubmit)
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
  
  func handleSubmit() {
    if let pane = layout.layoutWithID(nav.selection) {
      pane.model.link = url
    }
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
    Overlay(layout: $layout, url: "https://elegantchaos.com")
  }
  .frame(width: 640, height: 480)
}
