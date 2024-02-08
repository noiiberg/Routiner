//
//  AddView.swift
//  Routiner
//
//  Created by Noi Berg on 07.02.2024.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var routine: Item
    
    // Closing Sheet
    @Environment(\.dismiss) var dismiss
    
    @State private var name = String()
    @State private var type = "Note Done"
    
    var types = ["Note Done", "Done"]
    

    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    TextField("Name", text: $name)
                    Picker(selection: $type) {
                        ForEach(self.types, id: \.self) {
                            Text($0)
                        }
                    } label: {
                        Text("Status")
                    }
                }
                .navigationTitle("Add a routine")
                .toolbar(content: {
                    Button(action: {
                            let item = Items(name: self.name, type: self.type)
                            self.routine.items.append(item)
                            self.dismiss.callAsFunction()
                            
                    }, label: {
                        Text("Create")
                    })
                })
            }
        }
    }
}
