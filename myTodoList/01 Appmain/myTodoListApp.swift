//
//  myTodoListApp.swift
//  myTodoList
//
//  Created by Freeborn Ehirhere on 08/09/2026.
//

import SwiftUI

@main
struct myTodoListApp: App {
    
    @StateObject var listViewModel = ListViewModel()
    
    @AppStorage("isDarkMode") var isDarkMode = false
    

    var body: some Scene {
        WindowGroup {
            ZStack {
                if listViewModel.showSplash {
                    SplashScreen()
                        .transition(.opacity)
                } else {
                    ListView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                }
            }
            .background(Color((#colorLiteral(red: 0.9960784314, green: 0.3137254902, blue: 0.2549019608, alpha: 1))))
        }
        .environmentObject(listViewModel)
       
    }
}


