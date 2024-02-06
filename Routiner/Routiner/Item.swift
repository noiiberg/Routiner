//
//  Item.swift
//  Routiner
//
//  Created by Noi Berg on 06.02.2024.
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
