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
    }
}

private extension UserBooking {
    func content() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.output.accommodations) { accommodation in
                    
                    ImageCarousel(accommodationPhoto: accommodation.images)
                    
                    Text("Даты бронирования:")
                        .bold()
                        .font(.system(size: 18))
                        .padding(.bottom,5)
                    
                    ForEach(accommodation.booking_dates) { accommodationb in
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
                    
                    // TODO: route to detail
                    AppButton(style: .standart,
                              title: "Подробнее",
                              action: {},
                              isButtonEnabled: true)

                    // TODO: delete 
                    AppButton(style: .standart,
                              title: "Удалить бронь",
                              action: {},
                              isButtonEnabled: true)
                    
                    Divider()
                        .background(.black)

                }
            }
            .padding()
        }
    }
}

#if DEBUG
struct UserBooking_Previews: PreviewProvider {
    static var previews: some View {
        UserBooking(viewModel: UserBookingViewModel(apiService: UserApiService()))
    }
}
#endif


