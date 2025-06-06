// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftData
import SwiftUI
import LoggerUI

struct OverlayView: View {
  @Binding var isVisible: Bool
  @Binding var activeSpace: SpaceItem?
  @ObservedObject var model: WebViewModel
  let focus: FocusBinding

  enum OverlayFocus {
    case url
  }

  @FocusState var overlayFocus: OverlayFocus?
  @State var link: String
  @State var selection: TextSelection?
  @State var showChannels = false
  
  var body: some View {
    VStack {
      TextField("URL", text: $link, selection: $selection)
        .focused($overlayFocus, equals: .url)
        .onSubmit(handleSubmit)
        .textFieldStyle(CustomTextFieldStyle())
        .padding()
        .background(
          Rectangle()
            .fill(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
        )
        

      HStack {
        SpacesView(activeSpace: $activeSpace)
        Spacer()
        BookmarksView(activeSpace: $activeSpace)
        Spacer()
        Button(action: handleShowChannels) {
          Image(systemName: "gear")
        }
      }
      .padding()
    }
    .frame(minWidth: 100, maxWidth: 1000)
    .onAppear(perform: handleAppear)
    .sheet(isPresented: $showChannels) {
      LoggerChannelsView()
        .frame(width: 600, height: 300)
    }
  }

  func handleShowChannels() {
    withAnimation {
      showChannels.toggle()
    }
  }
  
  @MainActor func handleAppear() {
    overlayFocus = .url
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: selectURLBody)
  }
  
  func handleCommit() {
    
  }
  
  func selectURLBody() {
    let text = model.url.absoluteString
    var start = text.index(text.startIndex, offsetBy: model.url.scheme?.count ?? 0)
    if text[start] == ":" {
      start = text.index(after: start) // Skip over the colon after the scheme
    }
    while text[start] == "/" {
      start = text.index(after: start) // Skip over any leading slashes
    }
    selection = .init(range: start..<text.endIndex)
  }
  
  func handleSubmit() {
    isVisible = false
    focus.wrappedValue = model.layout
    model.url = URL(string: link) ?? model.url
  }

}

struct CustomTextFieldStyle: TextFieldStyle {
  func _body(configuration: TextField<_Label>) -> some View {
    configuration
      .padding(.horizontal)
      .font(.title)
      .backgroundStyle(.clear)
      .disableAutocorrection(true)
      .textContentType(.URL)
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
      focus: $focus,
      link: "https://elegantchaos.com"
    )
  }
  .frame(width: 640, height: 480)
}
