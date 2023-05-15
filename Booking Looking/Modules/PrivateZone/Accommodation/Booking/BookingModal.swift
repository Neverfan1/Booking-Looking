//
//  BookingModal.swift
//  Booking Looking
//
//  Created by Данила Парамин on 01.05.2023.
//

import SwiftUI

struct BookingView: View {
    let freeDates: [DateModel]
    @State var selectedDates: [Date] = []
    
    var onBooking: () -> Void
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(freeDates, id: \.self) { freeDate in
                        CalendarView(freeDate: freeDate,
                                     selectedDates: $selectedDates)
                    }
                    
                    AppButton(style: .standart,
                              title: "Забронировать",
                              action: {
                                print(groupDatesByMonthAndYear(selectedDates))
                                onBooking()
                              },
                              isButtonEnabled: true)
                    
                }
            }
            .navigationBarTitle("Бронирование", displayMode: .inline)
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView( freeDates: [DateModel(month: 5, year: 2023, dates: [1,2,3,4,5,6,7]),
                                 DateModel(month: 6, year: 2023, dates: [4,7,9,10,11,12,13,14,20,26,27,28]),
                                 DateModel(month: 7, year: 2023, dates: [17,19,20,21,22,23,24,25,26,30])], onBooking: {}
                     )
    }
}
