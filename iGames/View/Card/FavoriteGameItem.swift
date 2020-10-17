//
//  FavoriteGameItem.swift
//  iGames
//
//  Created by Farhan Adji on 14/10/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteGameItem: View {
    var backgroundImage: String?
    var name: String?
    var released: String?
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                WebImage(url: URL(string: backgroundImage ?? ""))
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .resizable()
                    .renderingMode(.original)
                    .indicator(.activity)
                    .frame(
                        width: 100,
                        height: 70,
                        alignment: .center)
                    .cornerRadius(4)
                    .padding()
                    
                VStack(alignment: .leading) {
                    Text(name ?? "")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    Text((released?.toDate())?.getFormattedDate() ?? "-")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(Color.black.opacity(0.30))
                }
                .padding(.top)
                
                Spacer(minLength: 0)
            }
            .background(Color.white)
            .cornerRadius(9)
            .shadow(
                color: Color.black.opacity(0.18),
                radius: 4,
                x: 0,
                y: 4)
            .padding([.leading, .trailing])
            .padding(.bottom, 10)
        }
    }
}

struct FavoriteGameItem_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteGameItem()
    }
}
