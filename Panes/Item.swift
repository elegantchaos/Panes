//
//  Item.swift
//  Panes
//
//  Created by Sam Deane on 30/05/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
