//
//  Tab.swift
//  iGames
//
//  Created by Farhan Adji on 03/09/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct TabButton: View {
    var title: String
    @Binding var tab: String
    var body: some View {
        Button(action: {
            self.tab = self.title
        }) {
            HStack(spacing: 8) {
                Image(title)
                    .renderingMode(.template)
                    .foregroundColor(tab == title ? .white : .gray)
                
                Text(tab == title ? title : "")
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.black.opacity(tab == title ? 1 : 0))
        .clipShape(Capsule())
        }
    }
}
