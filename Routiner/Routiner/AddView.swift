//
//  AddView.swift
//  Routiner
//
//  Created by Noi Berg on 07.02.2024.
//

import SwiftUI

struct AddView: View {
    
    var statuses = ["Not Done", "Done"]
    
    @ObservedObject var routine: Item
    @Environment(\.dismiss) var dismiss // Closing Sheet
    @State private var name = String()
    @State private var status = "Not Done"
    @FocusState private var isFocusedField: Bool

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
                        guard name != "" else { return }
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
