//
//  Button.swift
//  madApp
//
//  Created by Nikolay Truhin on 24/12/22.
//

import SwiftUI

struct Button: View {
    let bgColor: Color
    let text: String
    var icon: Image? = nil
    let completion: () -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            Spacer()
            Text(text).font(.custom(.boldFont, size: 22))
            if let icon = icon {
                icon
            }
            Spacer()
        }.padding(14).background(bgColor).cornerRadius(4)
            .onTapGesture(perform: completion)
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Button(bgColor: .red, text: "tess", icon: nil) {}
    }
}
