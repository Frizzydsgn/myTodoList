//
//  03 SplashScreen.swift
//  myTodoList
//
//  Created by Freeborn Ehirhere on 10/09/2026.
//

import SwiftUI

struct SplashScreen: View {
    
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var isScaled = false
   
    
    var body: some View {
        
        ZStack {
            
            Color((#colorLiteral(red: 0.9960784314, green: 0.3137254902, blue: 0.2549019608, alpha: 1)))
                .ignoresSafeArea()
            
            
            Image("appIcon")
                .resizable()
                .frame(width: 120, height: 120)
                .scaleEffect(isScaled ? 1.2 : 0.5)
                .opacity(isScaled ? 1 : 0)
            
        }
        .onAppear {
            
            withAnimation(.easeIn(duration: 0.8)) {
                isScaled = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeIn(duration: 0.5)) {
                    listViewModel.showSplash = false
                }
            }
        }
        
    }
       
    }


#Preview {
    SplashScreen()
        .environmentObject(ListViewModel())
}
