import SwiftUI

struct ExpenceItem : Identifiable, Encodable , Decodable{
    var id = UUID()
    
    var value: Int
    var name: String
    var type: String
    var currency: String
}

class Expencec : ObservableObject {
    @Published var items = [ExpenceItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    @Published var types = ["Bussines", "Personal","+"] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(types) {
                UserDefaults.standard.set(encoded, forKey: "Types")
            }
        }
    }
    @Published var names: [String] = ["Налоги 🤬","+"] {
        didSet {
            if let encoded = try? JSONEncoder().encode(names) {
                UserDefaults.standard.set(encoded, forKey: "Names")
            }
                
        }
    }
    @Published var currencies: [String] = ["USD", "EUR", "RUB", "BYN"]
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenceItem].self, from: items) {
                self.items = decoded

            }
        }
        
        if let types = UserDefaults.standard.data(forKey: "Types") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([String].self, from: types) {
                self.types = decoded
                if (self.types.last ?? "") != "+" {
                    self.types.append("+")
                }
            }
        }
        
        if let names = UserDefaults.standard.data(forKey: "Names") {
            if let decoded = try? JSONDecoder().decode([String].self, from: names) {
                self.names = decoded
                if (self.names.last ?? "") != "+" {
                    self.names.append("+")
                }
            }
        }
    }
}



