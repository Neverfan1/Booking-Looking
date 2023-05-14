//
//  StateView.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 14.05.2023.
//

import SwiftUI
import Combine

struct StateView<Content: View>: View {
    
    let state: ProcessingState
    let onAppear: PassthroughSubject<Void, Never>
    let content: () -> Content
    
    init(state: ProcessingState,
         onAppear: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>(),
         content: @escaping () -> Content) {
        self.state = state
        self.onAppear = onAppear
        self.content = content
    }
    
    var body: some View {
        stateViewBuilder()
            .onAppear(perform: onAppearSend)
    }
}

private extension StateView {
    func stateViewBuilder() -> some View {
        VStack {
            switch state {
            case .error(let message):
                errorView(message: message)
            case .loading:
                loadingView
            case .loaded:
                content()
            }
        }
    }
    
    func errorView(message: String) -> some View {
        VStack(spacing: 12) {
            Text(message)
                .font(.title)
            
            Button(action: onAppearSend) {
                Text("Повторить")
            }
        }
    }
    
    var loadingView: some View {
        ProgressView()
    }
}

private extension StateView {
    func onAppearSend() {
        onAppear.send()
    }
}

#if DEBUG
struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        StateView(state: .loaded,
                  onAppear: PassthroughSubject<Void, Never>(),
                  content: {
            EmptyView()
        })
    }
}
#endif
