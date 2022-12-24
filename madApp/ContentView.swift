//
//  ContentView.swift
//  madApp
//
//  Created by Nikolay Truhin on 24/12/22.
//

import SwiftUI

enum Screen {
    case login
    case start
    case main
}

struct ContentView: View {
    @State var screen: Screen = .start
    
    @AppStorage("key") var key: String?
    
    var body: some View {
        switch screen {
        case .login:
            LoginScreen(successLogin: successLogin)
        case .start:
            PreviewScreen(animationEnded: previewAnimationEnded)
        case .main:
            MainScreen()
        }
    }
    
    func previewAnimationEnded() {
        if let key = key {
            screen = .main
        } else {
            screen = .login
        }
    }
    
    func successLogin() {
        let test = key
        screen = .main
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
