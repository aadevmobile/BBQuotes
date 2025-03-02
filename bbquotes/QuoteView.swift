//
//  QuoteView.swift
//  bbquotes
//
//  Created by Anie on 1/14/25.
//

import SwiftUI

struct QuoteView: View {
    //let vm = ViewModel()
    let show: String
    
    var body: some View {
        TabView {
            Tab ("Breaking Bad", systemImage: "tortoise") {
               Text("Breaking Bad")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab ("Better Call Saul", systemImage: "briefcase") {
                Text("Better Call Saul")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    QuoteView(show:"Breaking Bad")
        .preferredColorScheme(.dark)
}
