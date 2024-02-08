//
//  ContentView.swift
//  Routiner
//
//  Created by Noi Berg on 06.02.2024.
//

import SwiftUI

struct TaskRow: View {
    var body: some View {
        ContentView()
    }
}

struct ContentView: View {
    
    @State private var showingAddItem = false
    @ObservedObject var routineItem = Item()
    
    var body: some View {
        VStack {
            NavigationStack {
                
                
                // chart
                Spacer()
                    .padding()
                
                
                
                // chart title
                
                Button {
                    self.showingAddItem = true
                } label: {
                    Text("Create a routine")
                        .padding(10)
                }
                .sheet(isPresented: $showingAddItem, content: {
                    AddView(routine: self.routineItem)
                })
                .buttonStyle(.bordered)
                List {
                    ForEach(routineItem.items.reversed(), id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text("Icon")
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
