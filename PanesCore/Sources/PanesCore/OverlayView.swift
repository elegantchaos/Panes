// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftData
import SwiftUI

struct OverlayView: View {
  @Binding var isVisible: Bool
  @Binding var activeSpace: SpaceItem?
  @ObservedObject var model: WebViewModel
  let focus: FocusBinding

  enum OverlayFocus {
    case url
  }

  @FocusState var overlayFocus: OverlayFocus?

  var body: some View {
    VStack {
      TextField("URL", text: urlBinding)
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

      SpacesView(activeSpace: $activeSpace)

    }
    .onAppear {
      overlayFocus = .url
    }
  }

  func handleSubmit() {
    isVisible = false
    focus.wrappedValue = model.layout
  }

  var urlBinding: Binding<String> {
    Binding(
      get: { model.url.absoluteString },
      set: { newValue in
        if let url = URL(string: newValue) {
          model.url = url
        }
      }
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
  @Previewable @State var layout = LayoutItem()
  @Previewable @State var activeSpace: SpaceItem?

  @FocusState var focus: LayoutItem?

  VStack {
    OverlayView(
      isVisible: .constant(true),
      activeSpace: $activeSpace,
      model: WebViewModel(URL(link: "https://elegantchaos.com"), layout: layout),
      focus: $focus
    )
  }
  .frame(width: 640, height: 480)
}
