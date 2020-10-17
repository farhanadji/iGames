//
//  RatingView.swift
//  iGames
//
//  Created by Farhan Adji on 04/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    var rating: Double = 3.4
    var size: CGFloat = 14
    var lineWidth: CGFloat = 1
    @State var color: Color = Color.clear
    var body: some View {
        Text(String(rating))
            .font(.system(size: self.size))
            .bold()
            .foregroundColor(self.color)
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 4)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: self.lineWidth)
                    .foregroundColor(self.color)
            )
            .onAppear {
                self.setColor()
        }
    }
    
    func setColor() {
        switch rating {
        case 0...1.9:
            self.color = Color.red
        case 2...2.9:
            self.color = Color.orange
        case 3...3.9:
            self.color = Color.green.opacity(0.7)
        case 4...5:
            self.color = Color.green
        default:
            self.color = Color.black
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
