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
        .sheet(isPresented: $viewModel.output.showingFilter) {
            FilterView(filter: $viewModel.output.filterSettings,
                       onSearchUpdate: viewModel.input.onSettingsUpdate)
        }
    }

}

private extension SearchAccommodation {
    func content() -> some View {
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
