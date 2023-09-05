//
//  ContentView.swift
//  my costs
//
//  Created by admin on 15.07.23.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var expenses = Expencec()
    @State private var showAddView = false
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) {item in
                    HStack {
                        VStack(alignment: .leading){
                            Text(item.name)
                            Text(item.type)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(String(item.value) + " " + item.currency)
                    }
                    .frame(height: 20)
                }
                .onDelete(perform: {expenses.items.remove(atOffsets: $0)})
                .onMove(perform: {expenses.items.move(fromOffsets: $0, toOffset: $1)})
            }
            .navigationTitle("Мои расходы")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showAddView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showAddView) {
                        AddView(expenses: self.expenses)
                    }

                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(expenses: expenses), label: {Text("Settings")})
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
