//
//  AddView.swift
//  my costs
//
//  Created by admin on 15.07.23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismissMode
    
    @State private var name = UserDefaults.standard.string(forKey: "LastName") ?? ""
    @State private var newName = ""
    
    @State private var type = UserDefaults.standard.string(forKey: "LastType") ?? "Personal"
    @State private var newType = ""
    
    @State private var amount = "" {
        didSet {
            errorAmount = false
        }
    }
    @State private var currency = UserDefaults.standard.string(forKey: "LastCurrency") ?? "BYN"
    
//    @State private var errorName = false
    @State private var errorAmount = false
    
    @ObservedObject var expenses: Expencec
//    let types = ["Bussines", "Personal"]
    
    var body: some View {
        NavigationView {
            Form{
                HStack {
                    if name == "+" {
                        HStack {
                            TextField("Название расхода", text: $newName)
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .onTapGesture {
                                    let new = newName
                                    newName = ""
                                    name = new
                                    if !expenses.names.contains(new) {
                                        expenses.names.insert(new, at: expenses.names.count-1)
                                    }
                                }
                            Image(systemName: "trash.slash")
                                .onTapGesture {
                                    newName = ""
                                    name = expenses.names.first!
                                }
                        }
                    } else {
                        Picker("Расход", selection: $name) {
                            ForEach(expenses.names, id: \.self) {
                                Text($0)
                            }
                        }
                    }
//                        .onChange(of: name) {_ in
//                            errorName = false
//                        }
//
//                    if errorName {
//                        Text("Укажите название")
//                            .foregroundColor(.red)
//                            .font(.footnote)
//                    }
                }
                if type == "+" {
                    HStack {
                        TextField("Название типа", text: $newType)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .onTapGesture {
                                let new = newType
                                newType = ""
                                type = new
                                if !expenses.names.contains(new) {
                                    expenses.types.insert(new, at: expenses.types.count-1)
                                }
                                
                               
                            }
                        Image(systemName: "trash.slash")
                            .onTapGesture {
                                newType = ""
                                type = expenses.types.first!
                            }
                    }
                } else {
                    Picker("Тип", selection: $type) {
                        ForEach(expenses.types, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Picker("Валюта", selection: $currency) {
                    ForEach(expenses.currencies, id: \.self) {
                        Text($0)
                    }
                }
                HStack {
                    TextField("Стоимость", text: $amount)
                        .keyboardType(.numberPad)
                        .onChange(of: amount) {newAmount in
                            if Int(newAmount) != nil {
                                errorAmount = false
                            }
                        }
                    if errorAmount {

                        Text("Неверный ввод")
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                }
            }.navigationTitle("Добавить")
            .toolbar {
                ToolbarItem {
                    HStack {
                        Button {
                            self.dismissMode.callAsFunction()
                        } label: {
                            Text("Отменить")
                        }
                        
                        Button {
                            if !name.isEmpty && !amount.isEmpty && Int(amount) != nil{
                                if type == "+" {
                                    type = newType
                                    if !expenses.types.contains(newType) {
                                        
                                        expenses.types.insert(newType, at: expenses.types.count-1)
                                    }
                                }
                                if name == "+" {
                                    name = newName
                                    if !expenses.names.contains(newName) {
                                        expenses.types.insert(newName, at: expenses.types.count-1)
                                    }
                                }
                                let expense = ExpenceItem(
                                    value: Int(amount)!,
                                    name: name,
                                    type: type, currency: currency)
                                expenses.items.insert(expense, at: 0)
                                
                                UserDefaults.standard.set(name, forKey: "LastName")
                                UserDefaults.standard.set(type, forKey: "LastType")
                                UserDefaults.standard.set(currency, forKey: "LastCurrency")
                                self.dismissMode.callAsFunction()
                            } else {
//                                errorName = name.isEmpty
                                errorAmount = amount.isEmpty || Int(amount) == nil
                            }
                            
                        } label: {
                            Text("Cохранить")
                        }
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expencec())
    }
}
