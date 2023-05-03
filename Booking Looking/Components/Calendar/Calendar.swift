//
//  Calendar.swift
//  Booking Looking
//
//  Created by Данила Парамин on 02.05.2023.
//

import SwiftUI

struct CalendarView: View {
    let freeDate: DateResponse
    @Binding var selectedDates: [Date]
    
    var body: some View {
        VStack {
            Text(String(freeDate.year) + ", " + monthNameFromNumberRu(freeDate.month))
                .font(.headline)
                .padding(.top)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(1...daysInMonth(freeDate.month, freeDate.year), id: \.self) { day in
                    Text("\(day)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(dateIsSelected(day: day) ? Color.blue : Color.clear)
                        .cornerRadius(8)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(freeDate.dates.contains(day) ? Color.green : Color.red, lineWidth: 2)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(8)
                        )
                        .onTapGesture {
                            if freeDate.dates.contains(day) {
                                toggleDateSelection(day: day)
                            }
                        }
                }
            }
        }
        .padding()
    }
    
    
    private func daysInMonth(_ month: Int, _ year: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    private func dateIsSelected(day: Int) -> Bool {
        if let date = dateFromFreeDateAndDay(freeDate: freeDate, day: day) {
            return selectedDates.contains(date)
        }
        return false
    }
    
    private func toggleDateSelection(day: Int) {
        if let date = dateFromFreeDateAndDay(freeDate: freeDate, day: day) {
            if let index = selectedDates.firstIndex(of: date) {
                selectedDates.remove(at: index)
            } else {
                selectedDates.append(date)
            }
        }
    }
    
    private func dateFromFreeDateAndDay(freeDate: DateResponse, day: Int) -> Date? {
        var components = DateComponents()
        components.year = freeDate.year
        components.month = freeDate.month
        components.day = day
        
        return Calendar.current.date(from: components)
    }
}

struct CalendarView_Previews: PreviewProvider {
    @State static var dates: [Date] = []
    
    static var previews: some View {
        CalendarView(freeDate: DateResponse(month: 5, year: 2023, dates: [1,2,3,4,5,6,7]), selectedDates: $dates)
    }
}


