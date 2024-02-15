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
    @State private var status = "Not Done"
    @FocusState private var isFocusedField: Bool
    
    var statuses = ["Not Done", "Done"]
    

    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    TextField("Name", text: $name)
                        .focused($isFocusedField)
                        .onAppear {
                            DispatchQueue.main.async {
                                self.isFocusedField = true
                            }
                        }
                    Picker(selection: $status) {
                        ForEach(self.statuses, id: \.self) {
                            Text($0)
                        }
                    } label: {
                        Text("Status")
                    }
                }
                .navigationTitle("Add a routine")
                .toolbar(content: {
                    Button(action: {
                            let item = Items(name: self.name, status: self.status)
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
