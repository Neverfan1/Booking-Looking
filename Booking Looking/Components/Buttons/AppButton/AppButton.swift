//
//  AppButton.swift
//  Booking Looking
//
//  Created by Данила Парамин on 21.04.2023.
//

import SwiftUI

struct AppButton: View {
    
    @Environment(\.isEnabled) private var isEnabled
    
    let style: AppButtonStyle
    let title: String
    let action: () -> Void
    let isButtonEnabled: Bool

    
    var body: some View {
        
        Button(action: action) {
        
            Text(title)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .font(.callout)
                .foregroundColor(style.textColor)
                .background(isButtonEnabled ? style.background : Color.gray)
                .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(style.borderColor,lineWidth: 3)
                        )
                .cornerRadius(40)
                .padding(.horizontal, 10)
                    
        }
        .disabled(!isButtonEnabled)
        
    }
}


struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(style: .authorization,
                  title: "Войти",
                  action: {},
        isButtonEnabled: false)
        
        
    }
}
