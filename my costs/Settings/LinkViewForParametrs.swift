//
//  LinkViewForParametrs.swift
//  my costs
//
//  Created by admin on 17.07.23.
//

import SwiftUI

struct LinkViewForParametrs: View {
    @State var listStrs: [String]
    let lable: String
    let keyForLastTap: String
    let onDelete: Optional<(Foundation.IndexSet) -> Void>
    let onMove: Optional<(IndexSet, Int) -> Void>
    let onAdd: (String) -> Void
    
    init(listStrs: [String], lable: String, keyForLastTap: String, onDelete: Optional< (Foundation.IndexSet) -> Void>, onMove: Optional< (IndexSet, Int) -> Void>, onAdd: @escaping (String) -> Void) {
        self.listStrs = listStrs
        self.lable = lable
        self.keyForLastTap = keyForLastTap
        self.onDelete = onDelete
        self.onMove = onMove
        self.onAdd = onAdd
        self.lastSelectedColum = UserDefaults.standard.string(forKey: keyForLastTap) ?? ""
    }
    
    @State private var isAdd = false
    @State private var text = ""
    @State private var lastSelectedColum: String
    var body: some View {
        NavigationView {
            List {
                ForEach(listStrs.dropLast(1), id: \.self) {text in
                    Button(text) {
                        lastSelectedColum = text
                        UserDefaults.standard.set(lastSelectedColum, forKey: keyForLastTap)
                    }
                    .foregroundColor(.black)
                        .frame(width: .infinity)
                        .listRowBackground(lastSelectedColum == text ? Color.blue : Color.white)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                
                if isAdd {
                    HStack {
                        TextField("Введите новый параметр", text: $text)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .onTapGesture {
                                let temp = text
                                text = ""
                                onAdd(temp)
                                listStrs.insert(temp, at: listStrs.count-1)
                                isAdd = false
                            }
                        Image(systemName: "trash.slash")
                            .onTapGesture {
                                text = ""
                                isAdd = false
                            }
                          
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        isAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .navigationTitle(lable)
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func delete(on offSet: IndexSet) -> Void {
        listStrs.remove(atOffsets:  offSet)
        self.onDelete!(offSet)
    }
    func move(on offSet: IndexSet, to: Int) -> Void {
        listStrs.move(fromOffsets: offSet, toOffset: to)
        self.onMove!(offSet,to)
    }
}

struct LinkViewForParametrs_Previews: PreviewProvider {
    static var previews: some View {
        var bob = ["lcefe", "test", "strs", "+"] 
        LinkViewForParametrs(listStrs: bob, lable: "Расходы тест", keyForLastTap: "LastN", onDelete: {bob.remove(atOffsets: $0)}, onMove: {bob.move(fromOffsets: $0, toOffset: $1)}, onAdd: {bob.insert($0, at: bob.count-1)})
    }
}
