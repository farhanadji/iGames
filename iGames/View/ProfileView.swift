//
//  ProfileView.swift
//  iGames
//
//  Created by Farhan Adji on 02/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject private var profileVM: ProfileViewModel = .shared
    var body: some View {
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
            
            Divider()
                .padding()
            VStack {
                Text("Your preference")
                    .font(.system(
                            size: 20,
                            weight: .bold,
                            design: .default))
                    .padding(.horizontal)
                
                HStack {
                    Text(self.profileVM.preference == nil ? "You haven't set preference. Set now?" : self.profileVM.preference?.name ?? "")
                        .font(.system(size: 16,
                                      weight: .regular,
                                      design: .default))
                        .foregroundColor(Color.black.opacity(0.38))
                    
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color.black.opacity(0.38))
                }.onTapGesture(perform: {
                    self.profileVM.isSetShowPreference = true
                })
                
                if self.profileVM.isSetShowPreference {
                    VStack {
                        Picker(selection: self.$profileVM.selectedPreference, label: Text("")) {
                            ForEach(self.profileVM.genres) { genre in
                                Text(genre.name ?? "").tag(genre.name ?? "")
                            }
                        }.id(UUID())
                        .labelsHidden()
                        
                        Button(action: {
                            self.profileVM.savePreference()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Save")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color.white)
                                Spacer()
                            }
                            .padding()
                            .background(Color.black)
                            .cornerRadius(8)
                        })
                    }
                }
            }
        }
        .padding()
    }
}
