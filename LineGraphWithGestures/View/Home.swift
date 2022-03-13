//
//  Home.swift
//  LineGraphWithGestures
//
//  Created by M200_Macbook_Pro on 2022/3/13.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "slider.vertical.3")
                        .font(.title2)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "person.circle")
                        .font(.title2)
                }
            }
            .padding()
            .foregroundColor(.black)
            
            VStack(spacing: 10) {
                Text("Total Balance")
                    .fontWeight(.bold)
                
                Text("$ 51 200")
                    .font(.system(size: 38, weight: .bold))
            }
            .padding(.top, 20)
            
            Button {
                
            } label: {
                HStack(spacing: 5) {
                    Text("Income")
                    Image(systemName: "chevron.down")
                }
                .font(.caption.bold())
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(.white, in: Capsule())
                .foregroundColor(.black)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: .black.opacity(0.05), radius: 5, x: -5, y: -5)
            }
            
            // Graph View
            LineGraph(data: samplePlot)
                .frame(height: 220)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Sample Plot For Graph
let samplePlot: [CGFloat] = [989, 1200, 750, 790, 650, 950, 1200, 600,
                             500, 600, 890, 1203, 1400, 900, 1250, 1600, 1200]
