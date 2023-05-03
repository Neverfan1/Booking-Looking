//
//  EnterCodeScreen2.swift
//  Booking Looking
//
//  Created by Данила Парамин on 22.04.2023.
//

import SwiftUI
import Combine

struct EnterCodeScreen2: View {
    @State private var code: String = ""
    @State private var isButtonEnabled = false

    var body: some View {
        VStack {
            topLogo
            codeField
            AppButton(style: .standart, title: "Войти", action: {}, isButtonEnabled: isButtonEnabled)
            
        }
    }
}

extension EnterCodeScreen2{
    var topLogo: some View{
        Image("logo")
            .renderingMode(.original)
            .resizable()
            .frame(width: UIScreen.main.bounds.width/1.3, height:  UIScreen.main.bounds.height/4.5)
            .padding(.bottom, UIScreen.main.bounds.height/5.6)
        
    }
    
    var codeField: some View{
        TextField("Код", text: $code)
            .keyboardType(.numberPad)
            .textFieldStyle(CustomTextFieldStyle())
            .onChange(of: code) { newValue in
                isButtonEnabled = newValue.count == 4 && newValue.allSatisfy { $0.isNumber }
            }
    }
}

struct EnterCodeScreen2_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeScreen2()
    }
}
