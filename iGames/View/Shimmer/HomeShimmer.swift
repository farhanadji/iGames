//
//  HomeShimmer.swift
//  iGames
//
//  Created by Farhan Adji on 04/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct HomeShimmer: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 0) {
                HomeTitleShimmer()
                    .padding(.top, -30)
                    .padding(.bottom, -40)
                ForEach(0...2, id: \.self) { _ in
                    CardShimmer()
                        .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
    }
}

struct HomeShimmer_Previews: PreviewProvider {
    static var previews: some View {
        HomeShimmer()
    }
}
