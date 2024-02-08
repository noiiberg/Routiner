//
//  Item.swift
//  Routiner
//
//  Created by Noi Berg on 07.02.2024.
//

import SwiftUI
import Foundation

struct Items: Identifiable, Codable {
    var id = UUID()
    
    let name: String
    let type: String
}


class Item: ObservableObject {
    
    
    @Published var items = [Items]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Items].self, from: items) {
                self.items = decoded
                
                return
            }
        }
    }
}
