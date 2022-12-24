//
//  InputField.swift
//  madApp
//
//  Created by Nikolay Truhin on 24/12/22.
//

import SwiftUI

struct InputField: View {
    var prompt: String
    @Binding var value: String
    var secure: Bool
    
    @ViewBuilder
    var content: some View {
        if secure {
            SecureField(prompt, text: $value)
        } else {
            TextField(prompt, text: $value)
        }
    }
    
    var body: some View {
        content.padding(12).background {
            RoundedRectangle(cornerRadius: 4).stroke(Color.border)
        }
    }
}

//struct InputField_Previews: PreviewProvider {
//    static var previews: some View {
//        InputField()
//    }
//}
