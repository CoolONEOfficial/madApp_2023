//
//  PreviewScreen.swift
//  madApp
//
//  Created by Nikolay Truhin on 24/12/22.
//

import SwiftUI

struct PreviewScreen: View {
    @State var isVisible = false
    
    let animationEnded: () -> Void
    
    var body: some View {
        VStack {
            if isVisible {
                ZStack {
                    Image("e1").position(x: 159, y: 200)
                    Image("e4").position(x: 300, y: 160)
                    Image("e2").position(x: 280, y: 355)
                    Image("e3").position(x: 85, y: 340)
                }.frame(height: 450).scaleEffect(1.05)
                Spacer()
                Text("TrainingSkills")
                    .font(.custom(.boldFont, size: 40))
                    .padding(.bottom, 8)
                Text("Prepare for competitions")
                    .font(.custom(.plainFont, size: 24))
            }
            Spacer()
        }.foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .background(Color.blackBg.ignoresSafeArea())
        .onAppear {
            withAnimation(.linear(duration: 3)) {
                isVisible = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    animationEnded()
                }
            }
        }
    }
}

struct PreviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        PreviewScreen() {}
    }
}
