//
//  CustomTextField.swift
//  Booking Looking
//
//  Created by Данила Парамин on 28.04.2023.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.56))
            .foregroundColor(.primary)
            .bold()
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 10)

    }
}
