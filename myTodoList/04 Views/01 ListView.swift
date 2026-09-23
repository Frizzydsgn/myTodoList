//
//  01 ListView.swift
//  myTodoList
//
//  Created by Freeborn Ehirhere on 08/09/2026.
//

import SwiftUI


struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State private var showContent = false
    
    
    // to change navigation TITLE COLOR
//    init() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithDefaultBackground()
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.blue]
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.blue]
//
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }
    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                if listViewModel.lists.isEmpty {
                  
                    VStack {
                        ContentUnavailableView {
                            Label("No items yet",
                                  systemImage: "list.bullet.clipboard.fill")
                        } description: {
                            Text("You don’t have any items on your list.\nAdd one to get started.")
                        } actions: {
                            NavigationLink(destination: {
                                AddView()
                            }) {
                                Text("Add Something")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(16)
                                    .background(
                                        
                                        Color((#colorLiteral(red: 0.9960784314, green: 0.3137254902, blue: 0.2549019608, alpha: 1)))
                                            .cornerRadius(100)
                                    )
                            }
                            
                        }
                    }
                    .padding(.bottom, 150)
                    .onAppear {
                        
                        guard !showContent else {return}
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeOut(duration: 0.5)) {
                               showContent = true
                                
                              
                            }
                        }
                    }
                   
                } else {
                    
                    List {
                        
                        ForEach(listViewModel.lists) { list in
                            
                            HStack {
                                Image(systemName: list.isCompleted ? "checkmark.circle" : "circle")
                                    .foregroundStyle(list.isCompleted ? .green : .gray)

                                Text(list.title)
                                    .foregroundStyle(Color("Text"))
                            }
                            .onTapGesture {
                                withAnimation(.linear) {
                                      listViewModel.toggleItem(item: list)
                                  }
                            }
                            
                            
                         

                        }
                        .onDelete(perform: listViewModel.deleteItem)
                        .onMove(perform: listViewModel.moveItem)
                        
                        
                    }
                    
                }
                
                
            }
            
            
   
            
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    
                    EditButton()
                })
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    
                    NavigationLink("Add", destination: {
                        
                        AddView()
                        
                    })
                    
                })
                
            }
            .tint(Color((#colorLiteral(red: 0.9960784314, green: 0.3137254902, blue: 0.2549019608, alpha: 1))))
            
           
        }
    }
}


#Preview {
    ListView()
        .environmentObject(ListViewModel())
    
}
