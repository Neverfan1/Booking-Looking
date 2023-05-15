//
//  FilterModal.swift
//  Booking Looking
//
//  Created by Данила Парамин on 29.04.2023.
//

import SwiftUI
import Combine

struct FilterView: View {
    @Binding var filter: Filter
    let onSearchUpdate: PassthroughSubject<Filter, Never>
    
    
    let housingTypes = ["Не выбрано", "Квартира", "Гостиница", "Дом"]
    let roomNumbers = [0] + Array(1...10)
    let bedNumbers = [0] + Array(1...20)
    let capacityNumbers = [0] + Array(1...30)
    
    @State private var selectedType: String = "Не выбрано"
    @State private var selectedRooms: Int = 0
    @State private var selectedBeds: Int = 0
    @State private var selectedCapacity: Int = 0
    
    @State private var priceTo: String = ""
    @State private var priceFrom: String = ""
    
    var body: some View {
        VStack{
            Form {
                typeSection
                roomsSection
                bedsSection
                capacitySection
                priceSection
            }
            
            AppButton(style: .standart,
                      title: "Поиск",
                      action: updateFilter,
                      isButtonEnabled:  true)
        }
        .navigationBarTitle("Фильтр", displayMode: .inline)
    }
}

private extension FilterView {
    var typeSection: some View{
        Section() {
            Picker("Тип жилища", selection: $selectedType) {
                ForEach(housingTypes, id: \.self) { type in
                    Text(type).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    var roomsSection: some View{
        Section() {
            Picker("Количество комнат", selection: $selectedRooms) {
                ForEach(roomNumbers, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    var bedsSection: some View{
        Section() {
            Picker("Количество кроватей", selection: $selectedBeds) {
                ForEach(bedNumbers, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    var capacitySection: some View{
        Section() {
            Picker("Вместимость", selection: $selectedCapacity) {
                ForEach(capacityNumbers, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    var priceSection: some View{
        Section(header: Text("Цена")) {
            TextField("Минимальная цена", text: $priceFrom)
                .keyboardType(.numberPad)
            TextField("Максимальная цена", text: $priceTo)
                .keyboardType(.numberPad)
        }
    }
}

private extension FilterView {
    func updateFilter() {
        filter.type = selectedType == "Не выбрано" ? nil : selectedType
        filter.rooms = selectedRooms == 0 ? nil : selectedRooms
        filter.beds = selectedBeds == 0 ? nil : selectedBeds
        filter.capacity = selectedCapacity == 0 ? nil : selectedCapacity
        filter.priceTo = priceTo.isEmpty ? nil :  Int(priceTo)
        filter.priceFrom = priceFrom.isEmpty ? nil :  Int(priceFrom)
        
        onSearchUpdate.send(filter)
    }
}

#if DEBUG
struct FilterView_Previews: PreviewProvider {
    @State static var filter: Filter = Filter(type: nil,rooms: nil,beds: nil,capacity: nil,priceTo: nil,priceFrom: nil)
    static var previews: some View {
        FilterView(filter: $filter,
                   onSearchUpdate: PassthroughSubject<Filter, Never>())
    }
}
#endif
