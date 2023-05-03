//
//  CodeCell.swift
//  Booking Looking
//
//  Created by Данила Парамин on 22.04.2023.
//

import SwiftUI

struct CodeCell: View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray,lineWidth: 1.5)
                .frame(width: 50, height: 50)
                .background(.gray.opacity(0.56))
                .cornerRadius(8)
            
            TextField("", text: $text)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .textFieldStyle(PlainTextFieldStyle())
                .multilineTextAlignment(.center)
                .font(.system(size: 24, weight: .bold, design: .default))
                .frame(width: 50, height: 50)
                .foregroundColor(.primary)
                .onReceive(text.publisher.collect(), perform: { newValue in
                    let filtered = newValue.filter(\.isWholeNumber)
                    self.text = String(filtered.prefix(1))
                })
        }
    }
}


struct CodeCell_Previews: PreviewProvider {
    @State static var text = "2"
    static var previews: some View {
        CodeCell(text: $text)
    }
}
