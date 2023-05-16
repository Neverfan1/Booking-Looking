//
//  SearchAccommodationScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import SwiftUI

struct SearchAccommodation: View {
    
    @StateObject var viewModel: SearchAccommodationViewModel
    
    var body: some View {
        StateView(state: viewModel.output.screenState,
                  onAppear: viewModel.input.onAppear,
                  content: content)
        .navigationBarItems(trailing: trailingButton)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.output.showingFilter) {
            FilterView(type: $viewModel.output.type,
                       rooms: $viewModel.output.rooms,
                       beds: $viewModel.output.beds,
                       capacity: $viewModel.output.capacity,
                       priceTo: $viewModel.output.priceTo,
                       priceFrom: $viewModel.output.priceFrom,
                       onTypeChange: viewModel.input.onTypeChange,
                       onRoomsChange: viewModel.input.onRoomsChange,
                       onBedsChange: viewModel.input.onBedsChange,
                       onCapacityChange: viewModel.input.onCapacityChange,
                       onPriceToChange: viewModel.input.onPriceToChange,
                       onPriceFromChange: viewModel.input.onPriceFromChange,
                       onSettingsSave: viewModel.input.onSettingsSave)
        }
    }
    
}

private extension SearchAccommodation {
    @ViewBuilder func content() -> some View {
        if viewModel.output.accommodations.isEmpty {
            emptyContent
        } else {
            successContent
        }
    }
    
    var successContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.output.accommodations) { accommodation in
                    AccommodationCard(model: accommodation,
                                      onCellTap: viewModel.input.onCellTap)
                }
            }
            .padding()
        }
    }
    
    var emptyContent: some View {
        Text("Жилья по вашим параметрам не найдено")
            .font(.headline)
    }
    
    var trailingButton: some View {
        Button(action: onTrailingTap) {
            Text("Filter")
                .foregroundColor(.black)
            Image(systemName: "line.horizontal.3.decrease.circle")
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

private extension SearchAccommodation {
    func onTrailingTap() {
        viewModel.input.onTrailingTap.send()
    }
}

#if DEBUG
struct SearchAccommodation_Previews: PreviewProvider {
    static var previews: some View {
        SearchAccommodation(viewModel: SearchAccommodationViewModel(apiService: AccommodationApiService(), router: nil))
    }
}
#endif
