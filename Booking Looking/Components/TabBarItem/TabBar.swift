//
//  TabBar.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import SwiftUI

struct TabBar: View {
    
    let title: String
    let refresh: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.system(size: 19, weight: .bold))
            Spacer()
            
            if refresh{
            ButtonRefresh(onRefresh: action)
            }
            
        }
        .padding(.bottom, 10)
        
    }
}

struct TabBar_Previews: PreviewProvider {
    @State static var text = "2"
    static var previews: some View {
        TabBar(title: "Test", refresh: true, action: {})
    }
}

    

