// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUI

struct Overlay: View {
  @Namespace var overlayFocusNamespace
  @Binding var isVisible: Bool
  @Binding var layout: PaneLayout
  @State var url: String
  let focus: FocusState<UUID?>.Binding
  @State var focussedPane: UUID?
  
  enum OverlayFocus {
    case url
  }
  
  @FocusState var overlayFocus: OverlayFocus?
  
  
  var body: some View {
    VStack {
      TextField("URL", text: $url)
        .focused($overlayFocus, equals: .url)
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
    .focusScope(overlayFocusNamespace)
    .onAppear {
      focussedPane = focus.wrappedValue
    }
  }
  
  func handleSubmit() {
    if let pane = layout.layoutWithID(focussedPane) {
      pane.model.link = url
      isVisible = false
      focus.wrappedValue = focussedPane
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

  @FocusState var focus: UUID?
  
  VStack {
    Overlay(
      isVisible: .constant(true),
      layout: $layout,
      url: "https://elegantchaos.com",
      focus: $focus
    )
  }
  .frame(width: 640, height: 480)
}
