//
//  OwnerAccommodationScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 15.05.2023.
//

import SwiftUI
import Combine

struct OwnerAccommodationScreen: View {
    
    let accommodations: [AccommodationSearchModel]
    
    var body: some View {
        StateView(state: .loading,
                  content: content)
    }

}

private extension OwnerAccommodationScreen {
    func content() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(accommodations) { accommodation in

                    AccommodationCard(model: accommodation,
                                      onCellTap: PassthroughSubject<Int, Never>())
                }
            }
            .padding()
        }
    }
}

struct OwnerAccommodationScreen_Previews: PreviewProvider {
    static var previews: some View {
        OwnerAccommodationScreen(accommodations: [AccommodationSearchModel.mock(),
                                             AccommodationSearchModel.mock2()])
    }
}
