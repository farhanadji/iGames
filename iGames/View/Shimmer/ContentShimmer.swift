//
//  ContentShimmer.swift
//  iGames
//
//  Created by Farhan Adji on 04/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct ContentShimmer: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0...5, id: \.self){ _ in
                TextShimmer()
                    .padding([.top, .bottom], -45)
            }
        }
    }
}

struct ContentShimmer_Previews: PreviewProvider {
    static var previews: some View {
        ContentShimmer()
    }
}
