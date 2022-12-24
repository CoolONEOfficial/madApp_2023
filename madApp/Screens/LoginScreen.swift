//
//  LoginScreen.swift
//  madApp
//
//  Created by Nikolay Truhin on 24/12/22.
//

import SwiftUI

struct LoginScreen: View {
    @State var login: String = "" //= "user5@mad.ru"
    @State var pass: String = "" //= "password"
    @State var showingAlert = false
    
    var successLogin: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Image("loginImage").scaleEffect(1.1)
            Spacer()
            HStack {
                Text("Sign In").font(.custom(.boldFont, size: 32))
                Spacer()
            }
            .padding(.bottom, 4)
            InputField(prompt: "Login", value: $login, secure: false)
            InputField(prompt: "Password", value: $pass, secure: true)
                .padding(.bottom, 4)
            Button(bgColor: .blackBg, text: "Login", icon: .init("loginIcon")) {
                Task {
                    await auth()
                }
            }.foregroundColor(.white)
            HStack(spacing: 4) {
                Text("Forgot password?").font(.custom(.plainFont, size: 14))
                Text("Get new").font(.custom(.boldFont, size: 14))
            }
            HStack(spacing: 4) {
                Text("Do you have an account?").font(.custom(.plainFont, size: 14))
                Text("Create new").font(.custom(.boldFont, size: 14))
            }
        }
        .padding(.horizontal, 24)
        .alert("Bad input", isPresented: $showingAlert) {
            SwiftUI.Button("OK", role: .cancel) { }
        }
    }
    
    @MainActor
    func auth() async {
        if login.isEmpty || pass.isEmpty {
            showingAlert = true
            return
        }
        
        if await NetworkService.shared.auth(mail: login, password: pass) {
            successLogin()
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen() {}
    }
}
