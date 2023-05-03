//
//  AccommodationDetailScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 30.04.2023.
//

import SwiftUI

struct AccommodationDetail: View {
    let accommodation: AccommodationDetailModel
    
    @State private var showingCalendar = false
        
    @State private var selectedImageIndex = 0
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageCarousel(accommodationPhoto: accommodation.images)
                Group{
                    type
                    address
                    price
                    description
                    rooms
                    beds
                    capacity
                    owner
                    cancellation_policy
                }
                .padding(.leading, 12)
                AppButton(style: .standart, title: "Выбрать даты", action: {
                    showingCalendar.toggle()
                }, isButtonEnabled: true)
                .sheet(isPresented: $showingCalendar) {
                    BookingView(freeDates: accommodation.free_dates) {
                        showingCalendar = false
                    }
                }
                .padding(.top)
                
                
            }
        }

    }
}

extension AccommodationDetail{
    
    
    
    var type: some View{
        HStack(alignment: .top)  {
            Text("Тип жилья:")
                .bold()
            Text(accommodation.type)
        }
        .padding(.top, 5)
        .font(.system(size: 18))
    }
    
    var address: some View{
        HStack(alignment: .top)  {
            Text("Адрес:")
                .bold()
            Text(accommodation.address)
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var price: some View{
        HStack(alignment: .top)  {
            Text("Цена за сутки:")
                .bold()
            Text(String(accommodation.price) + "руб.")
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var description: some View{
        HStack(alignment: .top) {
            Text("Описание:")
                .bold()
            Text(accommodation.description)
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var rooms: some View{
        HStack(alignment: .top)  {
            Text("Количество комнат:")
                .bold()
            Text(String(accommodation.rooms))
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var beds: some View{
        HStack(alignment: .top)  {
            Text("Количество кроватей:")
                .bold()
            Text(String(accommodation.beds))
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var capacity: some View{
        HStack(alignment: .top)  {
            Text("Вместимость:")
                .bold()
            Text(String(accommodation.capacity) + " чел.")
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var owner: some View{
        HStack(alignment: .top)  {
            Text("Владелец:")
                .bold()
            Text(accommodation.owner_name)
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var cancellation_policy: some View{
        HStack(alignment: .top)  {
            Text("Политика отмены:")
                .bold()
            Text(accommodation.cancellation_policy)
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
}

struct AccommodationDetail_Previews: PreviewProvider {
    static var previews: some View {
        AccommodationDetail(accommodation: AccommodationDetailModel.mock())
    }
}
