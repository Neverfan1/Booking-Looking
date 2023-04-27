//
//  EnterCodeScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 21.04.2023.
//

import SwiftUI

struct EnterCodeScreen1: View {
    @State private var code: [String] = ["", "", "", ""]
    @State private var isButtonEnabled = false
    @FocusState private var focusedField: Int?
    private let codeFieldIndices = Array(0..<4)

    var body: some View {
        VStack(spacing: 20) {
            topLogo
            Spacer()

            HStack {
                ForEach(codeFieldIndices, id: \.self) { index in
                    CodeCell(text: $code[index])
                        .focused($focusedField, equals: index)
                        .onChange(of: code[index]) { newValue in
                            if newValue.count == 1 && index < code.count - 1 {
                                focusedField = index + 1
                            }
                        }
                }
            }
            .padding()

            AppButton(style: .authorization,
                      title: "Войти",
                      action: {
                let combined = code.joined(separator: "")
                print(combined)
            },
                      isButtonEnabled: isButtonEnabled)
            Spacer()
        }
        .onChange(of: code) { newValue in
            isButtonEnabled = code.allSatisfy { !$0.isEmpty }
        }
        .padding()
    }
}


extension EnterCodeScreen1{
    var topLogo: some View{
        Image("logo")
            .renderingMode(.original)
            .resizable()
            .frame(width: UIScreen.main.bounds.width/1.3, height:  UIScreen.main.bounds.height/4.5)
            .padding(.bottom, UIScreen.main.bounds.height/5.6)
        
    }
}

struct EnterCodeScreen1_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeScreen1()
    }
}












