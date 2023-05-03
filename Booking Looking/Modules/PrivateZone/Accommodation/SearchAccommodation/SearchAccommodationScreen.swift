//
//  SearchAccommodationScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import SwiftUI

struct SearchAccommodation: View {
    let accommodations: [AccommodationSearchModel]
    
    @State private var filterSettings = Filter()
    @State private var showingFilter = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(accommodations) { accommodation in

                        AccommodationCard(model: accommodation)
                    }
                }
                .padding()
            }

            .navigationBarItems(trailing: Button(action: {
                showingFilter.toggle()
            }) {
                Text("Filter")
                    .foregroundColor(.black)
                Image(systemName: "line.horizontal.3.decrease.circle")
                    .font(.title)
                    .foregroundColor(.black)
            })
            .sheet(isPresented: $showingFilter) {
                FilterView(filter: $filterSettings) {
                    showingFilter = false
                }
            }
        }
    }

}


//private func filter(_ accommodation: AccommodationSearchModel, with filterSettings: Filter) -> Bool {
//    if let type = filterSettings.type, type != "Не выбрано" && type != accommodation.type {
//        return false
//    }
//    if let rooms = filterSettings.rooms, rooms != 0 && rooms != accommodation.rooms {
//        return false
//    }
//    if let beds = filterSettings.beds, beds != 0 && beds != accommodation.beds {
//        return false
//    }
//    if let capacity = filterSettings.capacity, capacity != 0 && capacity != accommodation.capacity {
//        return false
//    }
//    if let priceTo = filterSettings.priceTo, accommodation.price > priceTo {
//        return false
//    }
//    if let priceFrom = filterSettings.priceFrom, priceFrom != 0 && accommodation.price < priceFrom {
//        return false
//    }
//    return true
//}





struct SearchAccommodation_Previews: PreviewProvider {
    static var previews: some View {
        SearchAccommodation(accommodations: [AccommodationSearchModel.mock(),
                                             AccommodationSearchModel.mock2()])
    }
}
