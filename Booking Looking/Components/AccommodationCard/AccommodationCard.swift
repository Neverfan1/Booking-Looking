//
//  AccommodationCard.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import SwiftUI
import Combine

struct AccommodationCard: View {
    
    let model: AccommodationSearchModel
    let onCellTap: PassthroughSubject<Int, Never>
    
    var body: some View {
        Button {
            onCellTap.send(model.id)
        } label: {
            VStack(alignment: .center){
                photo
                name
                price
                address
                Divider()
            }
            .padding()
        }
    }
}

private extension AccommodationCard {
    var photo: some View{
        NetworkImage(imageURL: URL(string:model.imagePreview),
                     width: UIScreen.main.bounds.width/1.2,
                     height:  UIScreen.main.bounds.height/4,
                     cornerRadius: 10)
    }
    
    var name: some View{
        Text(model.type)
            .lineLimit(1)
            .truncationMode(.tail)
            .foregroundColor(.primary)
    }
    
    var price: some View{
        
        Text(String(model.price) + " руб/сутки")
            .lineLimit(1)
            .truncationMode(.tail)
            .font(.caption2)
            .foregroundColor(.green)
            .bold()
    }
    var address: some View{
        
        Text(model.address)
            .lineLimit(1)
            .truncationMode(.tail)
            .font(.caption2)
            .foregroundColor(.primary)
            .opacity(0.4)
    }
}


struct AccommodationCard_Previews: PreviewProvider {
    static var previews: some View {
        AccommodationCard(model: AccommodationSearchModel.mock(), onCellTap: PassthroughSubject<Int, Never>())
    }
}

