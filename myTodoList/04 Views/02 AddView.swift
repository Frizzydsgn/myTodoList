//
//  02 AddView.swift
//  myTodoList
//
//  Created by Freeborn Ehirhere on 08/09/2026.
//

import SwiftUI

struct AddView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
   @Environment(\.dismiss) var dismiss
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false

    
    @AppStorage("isDarkMode") var isDarkMode = false
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 40) {
                    TextField("type something here...", text: $listViewModel.addText)
                        .padding()
                        .background(
                            Color.gray.opacity(0.1)
                                .cornerRadius(12)
                        )
                    
                    
                    
                    Button(action: {
                        
                      
                       addItem()
                  
                        
                    }, label: {
                        
                        Text("Save".uppercased())
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                
                                Color((#colorLiteral(red: 0.9960784314, green: 0.3137254902, blue: 0.2549019608, alpha: 1)))
                            
                            )
                            .cornerRadius(100)
                           
                    })
              

                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                .padding()
                
                
            }
            
            .navigationTitle("Add an Item")
            .alert(isPresented: $showAlert) {
                
                getAlert()
            }
       
            .tint(Color((#colorLiteral(red: 0.9960784314, green: 0.3137254902, blue: 0.2549019608, alpha: 1))))
        }
        
      
    }
    
    //append

    func addItem() {
    
        if correctField() {
            
            listViewModel.lists.append(
                
                ListModel(id: UUID(), title: listViewModel.addText, isCompleted: false)
            )
            
            listViewModel.addText = ""
            dismiss()
            
        }
        
    }
    
    
    func correctField() -> Bool {
        
        if listViewModel.addText.count < 2 {
            
            alertTitle = "Todo Item must be at least 3 characters long😔"
            showAlert.toggle()
            return false
            
        }
        return true
        
    }
    
    
    
    func getAlert() -> Alert {
        
        return Alert(title: Text(alertTitle))
    }
}

#Preview {
    AddView()
        .environmentObject(ListViewModel())
}
