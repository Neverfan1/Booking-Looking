//
//  FilterModal.swift
//  Booking Looking
//
//  Created by Данила Парамин on 29.04.2023.
//

import SwiftUI
import Combine

struct FilterView: View {
    @Binding var type: String
    @Binding var rooms: Int
    @Binding var beds: Int
    @Binding var capacity: Int
    @Binding var priceTo: String
    @Binding var priceFrom: String
    
    let onTypeChange: PassthroughSubject<String, Never>
    let onRoomsChange: PassthroughSubject<Int, Never>
    let onBedsChange: PassthroughSubject<Int, Never>
    let onCapacityChange: PassthroughSubject<Int, Never>
    let onPriceToChange: PassthroughSubject<String, Never>
    let onPriceFromChange: PassthroughSubject<String, Never>
    
    let onSettingsSave: PassthroughSubject<Void, Never>
    
//    @State var filterPriceFrom: String = ""
//    @State var filterPriceTo: String = ""
    
    let housingTypes = ["Не выбрано", "Квартира", "Гостиница", "Дом"]
    let roomNumbers = [0] + Array(1...10)
    let bedNumbers = [0] + Array(1...20)
    let capacityNumbers = [0] + Array(1...30)
    
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
                      action: save,
                      isButtonEnabled:  true)
        }
        .navigationBarTitle("Фильтр", displayMode: .inline)
    }
}

private extension FilterView {
    var typeSection: some View{
        Section() {
            Picker("Тип жилища", selection: $type) {
                ForEach(housingTypes, id: \.self) { type in
                    Text(type).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: type) { newValue in
                onTypeChange.send(newValue)
            }
        }
    }
    
    var roomsSection: some View{
        Section() {
            Picker("Количество комнат", selection: $rooms) {
                ForEach(roomNumbers, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: rooms) { newValue in
                onRoomsChange.send(newValue)
            }
        }
    }
    
    var bedsSection: some View{
        Section() {
            Picker("Количество кроватей", selection: $beds) {
                ForEach(bedNumbers, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: beds) { newValue in
                onBedsChange.send(newValue)
            }
        }
    }
    
    var capacitySection: some View{
        Section() {
            Picker("Вместимость", selection: $capacity) {
                ForEach(capacityNumbers, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: capacity) { newValue in
                onCapacityChange.send(newValue)
            }
        }
    }
    
    var priceSection: some View{
        Section(header: Text("Цена")) {
            TextField("Минимальная цена", text: $priceFrom)
                .keyboardType(.numberPad)
                .onChange(of: priceFrom) { newValue in
                    onPriceFromChange.send(newValue)
                }
            
            TextField("Максимальная цена", text: $priceTo)
                .keyboardType(.numberPad)
                .onChange(of: priceTo) { newValue in
                    onPriceFromChange.send(newValue)
                }
        }
    }
}

private extension FilterView {
    func save() {
        onSettingsSave.send()
    }
}

//#if DEBUG
//struct FilterView_Previews: PreviewProvider {
//    @State static var filter: Filter = Filter(type: nil,rooms: nil,beds: nil,capacity: nil,priceTo: nil,priceFrom: nil)
//    static var previews: some View {
//        FilterView(
//                   onTypeChange: PassthroughSubject<String, Never>(),
//                   onRoomsChange: PassthroughSubject<Int?, Never>(),
//                   onBedsChange: PassthroughSubject<Int?, Never>(),
//                   onCapacityChange: PassthroughSubject<Int?, Never>(),
//                   onPriceToChange: PassthroughSubject<Int?, Never>(),
//                   onPriceFromChange: PassthroughSubject<Int?, Never>(),
//                   onSettingsSave: PassthroughSubject<Void, Never>())
//    }
//}
//#endif
