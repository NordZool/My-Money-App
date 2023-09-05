import SwiftUI

struct ContentVie: View {
    @State private var selectedColumn: Int? = nil
    let columns = ["Column 1", "Column 2", "Column 3"]
    
    var body: some View {
        List {
            ForEach(columns.indices, id: \.self) { index in
                Text(columns[index])
                    .onTapGesture {
                        if selectedColumn == index {
                            selectedColumn = nil
                        } else {
                            selectedColumn = index
                        }
                    }
                    .listRowBackground(selectedColumn == index ? Color.blue : Color.white)
            }
        }
    }
}

struct prev : PreviewProvider {
    static var previews: some View {
        ContentVie()
    }
}
