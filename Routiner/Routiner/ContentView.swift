//
//  ContentView.swift
//  Routiner
//
//  Created by Noi Berg on 06.02.2024.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    @State private var showingAddItem = false
    @ObservedObject var routineItem = Item()
    
    let colors = Gradient(colors: [.blue, .purple, .blue])
    let iconMappings: [String: (Image, Color)] = ["Note Done": (Image(systemName: "seal"), Color.gray),
                                                  "Done": (Image(systemName: "checkmark.seal.fill"), Color.green)]
    
    var body: some View {
        VStack {
            NavigationStack {
                
                Spacer()
                
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(style: StrokeStyle(lineWidth: 22, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.gray.opacity(0.3))
                    
                    let doneItemsCount = routineItem.items.filter { $0.status == "Done" }.count
                    let totalItemsCount = routineItem.items.count
                    let completionPercentage = doneItemsCount > 0 ? Double(doneItemsCount) / Double(totalItemsCount) : 0
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(completionPercentage))
                        .stroke(AngularGradient(gradient: colors, center: .center,
                                                startAngle: .degrees(0), endAngle: .degrees(360)),
                                style: StrokeStyle(lineWidth: 22, lineCap: .round, lineJoin: .round))
                        .rotationEffect(Angle(degrees: 90))
                    
                    Text("\(Int(completionPercentage * 100))%")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                }
                
                .frame(width: 180, height: 180)
                .padding()
                
                Spacer()
                
                Text("Completed in a day")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
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
                    ForEach(routineItem.items.indices, id: \.self) { index in
                        let item = routineItem.items[index]
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.status)
                            }
                            Spacer()
                            
                            if let (icon, color) = iconMappings[item.status] {
                                Button {
                                    // The button has no action yet
                                } label: {
                                    icon.imageScale(.large)
                                        .foregroundStyle(color)
                                }
                                .contextMenu(menuItems: {
                                    Button {
                                        routineItem.items[index].status = (item.status == "Done") ? "Note Done" : "Done"
                                    } label: {
                                        Text("Change status")
                                        Image(systemName: "arrow.counterclockwise.circle.fill")
                                            .foregroundStyle(Color.gray)
                                        
                                    }
                                    
                                    
                                })
                                
                            }
                            
                        }
                    }
                    
                    .onDelete(perform: { indexSet in
                        routineItem.items.remove(atOffsets: indexSet)
                    })
                }
                .navigationTitle("My routine")
                
            }
        }
    }
    
    
}


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
#Preview {
    ContentView()
}
