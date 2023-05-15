//
//  AccommodationDetailScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 30.04.2023.
//

import SwiftUI

struct AccommodationDetail: View {
        
    @StateObject var viewModel: AccommodationDetailViewModel
    
    var body: some View {
        StateView(state: viewModel.output.screenState,
                  onAppear: viewModel.input.onAppear,
                  content: content)
        .sheet(isPresented: $viewModel.output.showingCalendar) {
            BookingView(freeDates: viewModel.output.accommodation.freeDates) {
                viewModel.output.showingCalendar = false
            }
        }
    }
}

private extension AccommodationDetail {
    func content() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageCarousel(accommodationPhoto: viewModel.output.accommodation.images)
                
                Group {
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
                
                AppButton(style: .standart,
                          title: "Выбрать даты",
                          action: onDateTap,
                          isButtonEnabled: true)
                .padding(.top)
            }
        }
    }
    
    var type: some View {
        HStack(alignment: .top) {
            Text("Тип жилья:")
                .bold()
            Text(viewModel.output.accommodation.type)
        }
        .padding(.top, 5)
        .font(.system(size: 18))
    }
    
    var address: some View {
        HStack(alignment: .top)  {
            Text("Адрес:")
                .bold()
            Text(viewModel.output.accommodation.address)
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var price: some View {
        HStack(alignment: .top)  {
            Text("Цена за сутки:")
                .bold()
            Text(String(viewModel.output.accommodation.price) + "руб.")
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var description: some View {
        HStack(alignment: .top) {
            Text("Описание:")
                .bold()
            Text(viewModel.output.accommodation.description)
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var rooms: some View {
        HStack(alignment: .top) {
            Text("Количество комнат:")
                .bold()
            Text(String(viewModel.output.accommodation.rooms))
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var beds: some View {
        HStack(alignment: .top) {
            Text("Количество кроватей:")
                .bold()
            Text(String(viewModel.output.accommodation.beds))
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var capacity: some View {
        HStack(alignment: .top) {
            Text("Вместимость:")
                .bold()
            Text(String(viewModel.output.accommodation.capacity) + " чел.")
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var owner: some View {
        HStack(alignment: .top) {
            Text("Владелец:")
                .bold()
            Text(viewModel.output.accommodation.ownerName)
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
    var cancellation_policy: some View {
        HStack(alignment: .top) {
            Text("Политика отмены:")
                .bold()
            Text(viewModel.output.accommodation.cancellationPolicy)
        }
        .padding(.top, 5)
        .font(.system(size: 18))
        
    }
    
}

private extension AccommodationDetail {
    func onDateTap() {
        viewModel.input.onDateTap.send()
    }
}

struct AccommodationDetail_Previews: PreviewProvider {
    static var previews: some View {
        AccommodationDetail(viewModel: AccommodationDetailViewModel(id: 1,
                                                                    apiService: AccommodationApiService()))
    }
}
