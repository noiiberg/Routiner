//
//  ContentView.swift
//  Routiner
//
//  Created by Noi Berg on 06.02.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAddItem = false
    @ObservedObject var routineItem = Item()
    
    let iconMappings: [String: (Image, Color)] = ["Note Done": (Image(systemName: "seal"), Color.gray),
                                                  "Done": (Image(systemName: "checkmark.seal.fill"), Color.green)]
    
    
    let imageSeal = Image(systemName: "seal")
    
    var body: some View {
        VStack {
            NavigationStack {
                
                
                // chart
                Spacer()
                    .padding()
                
                
                
                
                Text("Completed in a day")
                    .font(.system(size: 20))
                    .padding()
                
                Button {
                    self.showingAddItem = true
                } label: {
                    Text("Create a routine")
                        .padding(5)
                }
                .sheet(isPresented: $showingAddItem, content: {
                    AddView(routine: self.routineItem)
                })
                .buttonStyle(.bordered)
                
                .padding()
                
                List {
                    ForEach(routineItem.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            if let (icon, color) = iconMappings[item.type] {
                                           Button {
                                               //
                                           } label: {
                                               icon.foregroundStyle(color)
                                           }
                                           .contextMenu(menuItems: {
                                               Text("Reverse status")
                                           })
                                       }
                            
                        }
                    }
                    
                    .onDelete(perform: { indexSet in
                        routineItem.items.remove(atOffsets: indexSet)
                    })
                }
                
                // Background List color?
//                .listStyle(InsetGroupedListStyle())
//                .backgroundStyle(Color.white)
                .navigationTitle("Your routine")
                
            }
        }
//        .backgroundStyle(Color.white)
    }
    
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
#Preview {
    ContentView()
}
