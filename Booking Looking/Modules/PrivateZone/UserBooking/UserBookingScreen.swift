//
//  UserBookingScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 02.05.2023.
//

import SwiftUI

struct UserBooking: View {
    
    @StateObject var viewModel: UserBookingViewModel
    
    var body: some View {
        StateView(state: viewModel.output.screenState,
                  onAppear: viewModel.input.onAppear,
                  content: content)
        .navigationTitle(Text("Брони"))
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.output.isShowingAlert,
               content: alertContent)
    }
}

private extension UserBooking {
    @ViewBuilder func content() -> some View {
        if viewModel.output.accommodations.isEmpty {
            emptyContent
        } else {
            successContent
        }
    }
}

private extension UserBooking {
    var emptyContent: some View {
        Text("Брони отсутствуют")
            .font(.headline)
    }
    
    var successContent: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.output.accommodations, id: \.self) { accommodation in
                    
                    ImageCarousel(accommodationPhoto: accommodation.images)
                    
                    Text("Даты бронирования:")
                        .bold()
                        .font(.system(size: 18))
                        .padding(.bottom,5)
                    
                    datesList(accommodation.bookingDates)
                    
                    // TODO: route to detail
//                    AppButton(style: .standart,
//                              title: "Подробнее",
//                              action: {},
//                              isButtonEnabled: true)

                    AppButton(style: .standart,
                              title: "Удалить бронь",
                              action: { onDeleteTap(accommodation.bookingID) },
                              isButtonEnabled: true)
                    
                    Divider()
                        .background(.black)

                }
            }
            .padding()
        }
    }
    
    func datesList(_ values: [DateModel]) -> some View {
        ForEach(values) { accommodationb in
            VStack(alignment: .leading){
                HStack(alignment: .top)  {
                    Text("Год: ")
                        .bold()
                    Text(String(accommodationb.year))
                }
                .font(.system(size: 18))
                HStack(alignment: .top)  {
                    Text("Месяц: ")
                        .bold()
                    Text(monthNameFromNumberRu(_:)(accommodationb.month))
                }
                .font(.system(size: 18))
                
                HStack(alignment: .top)  {
                    Text("Даты: ")
                        .bold()
                    Text( accommodationb.dates.map { String($0) }.joined(separator: ", "))
                }
                .font(.system(size: 18))
                
                
            }
            Divider()
        }
    }
    
    func alertContent() -> Alert {
        Alert(title: Text(viewModel.output.alertMessage))
    }
    
    func onDeleteTap(_ value: Int) {
        viewModel.input.onDeleteTap.send(value)
    }
}

#if DEBUG
struct UserBooking_Previews: PreviewProvider {
    static var previews: some View {
        UserBooking(viewModel: UserBookingViewModel(apiService: UserApiService(),
                                                    bookingApiService: BookingApiService()))
    }
}
#endif


