// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 31/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

/// An active web session.
/// A PaneView displays one of these.
public class WebSession: ObservableObject {
  /// States that the session can be in.
  public enum State {
    case undefined
    case loading
    case loaded
  }
  
  /// The URL the session is showing.
  @Published var url: URL
  
  /// The state of the session.
  @Published var state: State = .undefined
  
  /// The title of the current page the session is showing.
  @Published var title: String
  
  /// The position that the pane occupies.
  @Published var position: LayoutItem

  /// Create a session.
  init (_ url: URL, layout: LayoutItem) {
    self.url = url
    self.title = ""
    self.position = layout
  }
  
  /// Label to use to represent this session.
  var label: String {
    title.isEmpty ? url.absoluteString : title
  }
}
