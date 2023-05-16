//
//  EnterCodeScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 21.04.2023.
//

import SwiftUI

struct EnterCodeScreen: View {
    
    @StateObject var viewModel: EnterCodeViewModel
    
    @State private var code: [String] = ["", "", "", ""]
    @State private var isButtonEnabled = false
    @FocusState private var focusedField: Int?
    private let codeFieldIndices = Array(0..<4)

    var body: some View {
        VStack(spacing: 20) {
            topLogo
            codeCells
            
            AppButton(style: .standart,
                      title: "Войти",
                      action: {
                viewModel.input.onConfirmTap.send()
            },
                      isButtonEnabled: isButtonEnabled)
            .padding(.top, UIScreen.main.bounds.height/13.6)
            Spacer()
        }
        .onChange(of: code) { newValue in
            isButtonEnabled = code.allSatisfy { !$0.isEmpty }
        }
        .padding()
    }
}


extension EnterCodeScreen{
    var topLogo: some View{
        Image("logo")
            .renderingMode(.original)
            .resizable()
            .frame(width: UIScreen.main.bounds.width/1.3, height:  UIScreen.main.bounds.height/4.5)
            .padding(.top, 14)
            .padding(.bottom, UIScreen.main.bounds.height/7.6)
        
    }
    
    var codeCells: some View{
        HStack {
            ForEach(codeFieldIndices, id: \.self) { index in
                CodeCell(text: $code[index])
                    .focused($focusedField, equals: index)
                    .onChange(of: code[index]) { newValue in
                        if newValue.count == 1 && index < code.count - 1 {
                            focusedField = index + 1
                        }
                        viewModel.input.onChangeCode.send(code.joined(separator: ""))
                    }
            }
        }
        .padding()

        
    }
}

struct EnterCodeScreen_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeScreen(viewModel: EnterCodeViewModel(apiService: AuthApiService(), router: nil))
    }
}












