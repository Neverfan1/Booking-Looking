//
//  BookingModal.swift
//  Booking Looking
//
//  Created by Данила Парамин on 01.05.2023.
//

import SwiftUI
import Combine

struct BookingView: View {
    
    @StateObject var viewModel: BookingViewModel
    
    var body: some View {
        StateView(state: viewModel.output.screenState,
                  content: content)
            .navigationBarTitle("Бронирование", displayMode: .inline)
            .onAppear {
                print(viewModel.output.freeDates)
            }
    }
}

private extension BookingView {
    func content() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.output.freeDates, id: \.self) { freeDate in
                    CalendarView(freeDate: freeDate,
                                 selectedDates: $viewModel.output.selectedDates)
                }
                
                AppButton(style: .standart,
                          title: "Забронировать",
                          action: buttonTap,
                          isButtonEnabled: true)
            }
        }
    }
}

private extension BookingView {
    func buttonTap() {
        print(groupDatesByMonthAndYear(viewModel.output.selectedDates))
        viewModel.input.onSave.send()
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView(viewModel: BookingViewModel(id: 1,
                                                freeDates: [.init(month: 1, year: 2023, dates: [1,2,3])],
                                                apiService: BookingApiService(),
                                                router: nil))
    }
}
