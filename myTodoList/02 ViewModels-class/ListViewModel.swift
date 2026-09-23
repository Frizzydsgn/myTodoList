import SwiftUI
import Combine

class ListViewModel: ObservableObject {

    @Published var addText = ""
    @Published var showSplash: Bool = true
    
    
    @Published var lists: [ListModel] = []

//    @Published var lists = [
////        ListModel(id: UUID(), title: "First Item in list", isCompleted: false),
////        ListModel(id: UUID(), title: "Second Item in list", isCompleted: false),
////        ListModel(id: UUID(), title: "Third Item in list", isCompleted: false)
//    ]

    let itemsKey: String = "lists_list"

    init() {
        loadItems()
    }

    // DELETE
    func deleteItem(indexSet: IndexSet) {
        lists.remove(atOffsets: indexSet)
        saveitems()
    }

    // MOVE
    func moveItem(from source: IndexSet, to destination: Int) {
        lists.move(fromOffsets: source, toOffset: destination)
        saveitems()
    }

    // UPDATE
//    func toggleItem(item: ListModel) {
//
//        if let index = lists.firstIndex(where: {
//            $0.title == item.title
//        }) {
//
//            lists[index].isCompleted.toggle()
//            saveitems()
//
//            if lists[index].isCompleted {
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//
//                    withAnimation {
//
//                        if let index = self.lists.firstIndex(where: {
//                            $0.title == item.title
//                        }) {
//                            self.lists.remove(at: index)
//                            self.saveitems()
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    func toggleItem(item: ListModel) {
        if let index = lists.firstIndex(where: {
            $0.id == item.id
        }) {
            lists[index].isCompleted.toggle()
            saveitems()
        }
    }
    

    // SAVE
    func saveitems() {

        if let encoded = try? JSONEncoder().encode(lists) {
            UserDefaults.standard.set(encoded, forKey: itemsKey)
        }
    }

    // LOAD
    func loadItems() {

        if let savedItems = UserDefaults.standard.data(forKey: itemsKey) {

            if let decodedItems = try? JSONDecoder().decode(
                [ListModel].self,
                from: savedItems
            ) {
                lists = decodedItems
            }
        }
    }
}
