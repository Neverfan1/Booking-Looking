//
//  EnterCodeScreen2.swift
//  Booking Looking
//
//  Created by Данила Парамин on 22.04.2023.
//

import SwiftUI
import Combine

struct EnterCodeScreen2: View {

    @StateObject var viewModel: EnterCodeViewModel
    
    var body: some View {
        StateView(state: viewModel.output.screenState,
                  content: content)
    }
}

private extension EnterCodeScreen2 {
    
    func content() -> some View {
        VStack {
            topLogo
            codeField
            AppButton(style: .standart,
                      title: "Войти",
                      action: onConfirmTap,
                      isButtonEnabled: viewModel.output.isButtonEnabled)
            
        }
    }
    
    var topLogo: some View{
        Image("logo")
            .renderingMode(.original)
            .resizable()
            .frame(width: UIScreen.main.bounds.width/1.3, height:  UIScreen.main.bounds.height/4.5)
            .padding(.bottom, UIScreen.main.bounds.height/5.6)
        
    }
    
    var codeField: some View{
        TextField("Код", text: $viewModel.output.code)
            .keyboardType(.numberPad)
            .textFieldStyle(CustomTextFieldStyle())
            .onChange(of: viewModel.output.code,
                      perform: onChangeOfCode)
    }
}

private extension EnterCodeScreen2 {
    func onChangeOfCode(_ value: String) {
        viewModel.input.onChangeCode.send(value)
    }
    
    func onConfirmTap() {
        viewModel.input.onConfirmTap.send()
    }
}

#if DEBUG
struct EnterCodeScreen2_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeScreen2(viewModel: EnterCodeViewModel(apiService: AuthApiService(), router: nil))
    }
}
#endif
