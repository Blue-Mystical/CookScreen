//
//  AboutMeView.swift
//  CookScreen
//
//  Created by Blue Snow on 5/6/2565 BE.
//

import SwiftUI

// Displays application information and the developer information
struct AboutMeView: View {
    var body: some View {
        ZStack {
            Color.ui.cream1
                .ignoresSafeArea()
            VStack {
                Image("CookScreenLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 160, alignment: .center)
                    .clipped()
                Text("CookScreen")
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .padding([.bottom], 10)
                VStack(alignment: .leading) {
                    Text("CookScreen is an application designed for cookers who want to organize their recipes in categories and list recipes with directions and ingredients they desire. Some cookers may have trouble remembering the ingredients and following the steps, of which our Application, CookScreen, is designed for.")
                        .font(.system(size: 16, design: .default))
                        .padding([.bottom], 5)
                    Text("Created by Annop Boonlieng (Student ID: 62090500443). Project for Mobile Application Development (CSS334) of King Mongkut's University of Technology Thonburi.")
                        .font(.system(size: 16, design: .default))
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 30, trailing: 10))
            .foregroundColor(Color.ui.cream5)
        }
    }
}

struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMeView()
    }
}
