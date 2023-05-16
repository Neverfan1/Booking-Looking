//
//  OwnerProfileScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 15.05.2023.
//

import SwiftUI
import Combine

struct OwnerProfileScreen: View {
    
    @StateObject var viewModel: OwnerProfileViewModel
    
    var body: some View {
        StateView(state: viewModel.output.screenState,
                  onAppear: viewModel.input.onAppear,
                  content: content)
        .navigationTitle("Профиль пользователя")
        .navigationBarTitleDisplayMode(.inline)
    }
}
extension OwnerProfileScreen{
    
    func content() -> some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                photoOwner
                nameOwner
                Divider()
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    descriptionOwner
                    contactOwner
                }
                .font(.system(size: 18))
                
                Text("Все жилища хозяина")
                    .padding(.top, 50)
                
                accomCells
            }
            .padding(.horizontal, 30)
        }
    }
    
    var photoOwner: some View {
        if viewModel.output.owner.image == "null" {
            return AnyView(
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            )
        } else {
            return AnyView(
                NetworkImage(imageURL: URL(string: viewModel.output.owner.image),
                             width: UIScreen.main.bounds.width / 1.2,
                             height: UIScreen.main.bounds.height / 4,
                             cornerRadius: 10)
            )
        }
    }

    var nameOwner: some View{
        Text(viewModel.output.owner.name)
            .font(.title)
            .fontWeight(.bold)
        
    }
    
    
    var descriptionOwner: some View{
        HStack {
            Text("Описание:")
                .fontWeight(.bold)
            Spacer()
            Text(viewModel.output.owner.description)
        }
    }
    
    
    var contactOwner: some View{
        HStack {
            Text("Телефон:")
                .fontWeight(.bold)
            Spacer()
            Text(viewModel.output.owner.contact)
        }
    }
    
    var accomCells: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(viewModel.output.accommodations) { accommodation in

                AccommodationCard(model: accommodation,
                                  onCellTap: viewModel.input.onAccomTap)
            }
        }
        .padding()
    }
}

private extension OwnerProfileScreen {
    
}

#if DEBUG
struct OwnerProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        OwnerProfileScreen(viewModel: OwnerProfileViewModel(id: (1,1), apiService: OwnerApiService(), router: nil))
    }
}
#endif
