//
//  SettingsView.swift
//  my costs
//
//  Created by admin on 16.07.23.
//

import SwiftUI

struct SettingsView: View {
    @State private var name = UserDefaults.standard.string(forKey: "LastName") ?? ""
    @State private var newName = ""
    @ObservedObject var expenses: Expencec
    
    var body: some View {
        Form {
            NavigationLink {
                LinkViewForParametrs(listStrs: expenses.names, lable: "Расходы", keyForLastTap: "LastName", onDelete: {expenses.names.remove(atOffsets:$0)}, onMove: {expenses.names.move(fromOffsets:$0,toOffset:$1)}, onAdd: {expenses.names.insert($0, at: expenses.names.count-1)})
            } label: {
                Text("Названия расходов")
            }
            NavigationLink {
                LinkViewForParametrs(listStrs: expenses.types, lable: "Типы расходов", keyForLastTap: "LastType", onDelete: {expenses.types.remove(atOffsets:$0)}, onMove: {expenses.types.move(fromOffsets:$0,toOffset:$1)}, onAdd: {expenses.types.insert($0, at: expenses.types.count-1)})
            } label: {
                Text("Типы расходов")
            }

        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(expenses: Expencec())
    }
}
