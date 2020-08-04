//
//  ProfileView.swift
//  iGames
//
//  Created by Farhan Adji on 02/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @Binding var isShowProfile: Bool
    var body: some View {
        NavigationView {
            VStack {
                Image("profile")
                    .resizable()
                    .frame(
                        width: 160,
                        height: 160)
                    .clipShape(Circle())
                    .padding()
                
                Text("Farhan Adji Nugroho")
                    .font(.system(
                        size: 24,
                        weight: .semibold,
                        design: .default))
                Text("farhanadji@live.com")
                    .foregroundColor(Color.black.opacity(0.38))
                Spacer()
            }
            .padding()
                
                
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.isShowProfile.toggle()
                }, label: {
                    Text("Done")
                        .bold()
                })
            )
        }
    }
}
