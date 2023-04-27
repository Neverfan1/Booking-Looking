//
//  ButtonRefresh.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import SwiftUI

struct ButtonRefresh: View {
    
    let onRefresh: () -> Void
    
    var body: some View {
        HStack(){
            Spacer()
        Button {
            onRefresh()
        } label: {
            Image(systemName: "gobackward")
                .foregroundColor(.primary)
                .scaleEffect(1.2)
                .frame(width: 50)
        }
        }

    }
}

struct ButtonRefresh_Previews: PreviewProvider {
    @State static var text = "2"
    static var previews: some View {
        ButtonRefresh(onRefresh: {})
    }
}

