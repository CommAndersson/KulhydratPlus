//
//  Profil.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 29/11/2023.
//

import SwiftUI

struct Profil: View {
    var body: some View {
        
        NavigationLink(destination: LoginSide(), label:{
            
            ZStack{
                Text("Login")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(.bottom, 2)
                
                Rectangle()
                    .frame(width: 300, height: 50)
                    .foregroundColor(.black.opacity(0))
                
            }
        })
        .frame(width: 300, height: 50)
        .background(Color("BlåTilKnapper"))
        .cornerRadius(10)
        .padding(.bottom, 20)
        .contentShape(Rectangle())
        
        
        NavigationLink(destination: MineKort(), label:{
            
            ZStack{
                Text("Mine Kort")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(.bottom, 2)
                
                Rectangle()
                    .frame(width: 300, height: 50)
                    .foregroundColor(.black.opacity(0))
                
            }
        })
        .frame(width: 300, height: 50)
        .background(Color("BlåTilKnapper"))
        .cornerRadius(10)
        .padding(.bottom, 20)
        .contentShape(Rectangle())
    }
}
