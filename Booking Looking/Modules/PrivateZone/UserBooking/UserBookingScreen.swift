//
//  UserBookingScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 02.05.2023.
//

import SwiftUI

struct UserBooking: View {
    let accommodations: [AccommodationBookingModel]
    @State private var selectedImageIndex = 0

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(accommodations) { accommodation in

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
                    AppButton(style: .standart,
                              title: "Подробнее",
                              action: {},
                    isButtonEnabled: true)

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

extension UserBooking{
}

struct UserBooking_Previews: PreviewProvider {
    static var previews: some View {
        UserBooking(accommodations: [AccommodationBookingModel.mock(),
                                     AccommodationBookingModel.mock()])
    }
}


