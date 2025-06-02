// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftData
import SwiftUI

struct Overlay: View {
  @Query private var spaces: [SpaceItem]
  @Binding var isVisible: Bool
  @ObservedObject var model: WebViewModel
  let focus: FocusBinding

  enum OverlayFocus {
    case url
  }

  @FocusState var overlayFocus: OverlayFocus?

  var body: some View {
    VStack {
      TextField("URL", text: $model.link)
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
      
      
      ForEach(spaces) { space in
        Button(action: handleSpaceTapped) {
          Text(space.name)
        }
      }

    }
    .onAppear {
      overlayFocus = .url
    }
  }

  func handleSubmit() {
    isVisible = false
    model.link = model.link
    focus.wrappedValue = model.layout
  }
  
  func handleSpaceTapped() {
    
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
//  @Previewable @State var layout: PaneLayout = .horizontal([
//    .single,
//    .vertical([.single, .single]),
//  ])

  @Previewable @State var layout = LayoutItem()
  @FocusState var focus: LayoutItem?

  VStack {
    Overlay(
      isVisible: .constant(true),
      model: WebViewModel(link: "https://elegantchaos.com", layout: layout),
      focus: $focus
    )
  }
  .frame(width: 640, height: 480)
}
