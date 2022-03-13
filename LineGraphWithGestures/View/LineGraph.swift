//
//  LineGraph.swift
//  LineGraphWithGestures
//
//  Created by M200_Macbook_Pro on 2022/3/13.
//

import SwiftUI

struct LineGraph: View {
    
    // Number of plots
    var data: [CGFloat]
    
    @State var currentPlot = ""
    
    // Offset ...
    @State var offset: CGSize = .zero
    @State var showPlot = false
    @State var translation: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            
            let height  = proxy.size.height
            let width   = (proxy.size.width) / CGFloat(data.count - 1)
            
            let maxPoint = (data.max() ?? 0) + 100
            
            let points = data.enumerated().compactMap { item -> CGPoint in
                // getting progress and multiplying with height ...
                let progress = item.element / maxPoint
                let pathHeight = progress * height
                // width ...
                let pathWidth = width * CGFloat(item.offset)
                
                // Since we need peak to top not bottom ...
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            
            
            ZStack {
                
                // Converting plot as points ...
                
                
                // Path ...
                Path { path in
                    // drawing the points
                    path.move(to: CGPoint(x: 0, y: 0))
                    
                    path.addLines(points)
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5,
                                         lineCap: .round,
                                         lineJoin: .round))
                .fill(
                    // Gradient ...
                    LinearGradient(colors: [.yellow.opacity(0.3), .yellow],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                
                // Path Background Coloring
                FillBG()
                // Clipping the shape ...
                    .clipShape(
                        Path { path in
                            // drawing the points
                            path.move(to: CGPoint(x: 0, y: 0))
                            
                            path.addLines(points)
                            path.addLine(to: CGPoint(x: proxy.size.width,
                                                     y: height))
                            path.addLine(to: CGPoint(x: 0,
                                                     y: height))
                        }
                    )
            }
            .overlay(
                // Drag Indicator ...
                VStack(spacing: 0) {
                    
                    Text(currentPlot)
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(.blue, in: Capsule())
                        .offset(x: translation < 10 ? 30 : 0)
                        .offset(x: translation > (proxy.size.width - 60) ? -30 : 0)
                    
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 1, height: 45)
                        .padding(.top)
                    
                    Circle()
                        .fill(.blue)
                        .frame(width: 22, height: 22)
                        .overlay(
                            Circle()
                                .fill(.white)
                                .frame(width: 12, height: 12)
                        )
                    
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 1, height: 45)
                    
                }
                // Fixed Frame ...
                // For Gesture Calculation
                    .frame(width: 80, height: 170)
                // 170 / 2 = 85 - 15 (circle ring size)
                    .offset(y: 70)
                    .offset(offset)
                    .opacity(showPlot ? 1 : 0),
                alignment: .bottomLeading
            )
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation { showPlot = true }
                        let translation = value.location.x - 40
                        // Getting index ...
                        let index = max(min(Int((translation / width).rounded() + 1), data.count - 1), 0)
                        currentPlot = "$ \(data[index])"
                        self.translation = translation
                        // removing half width
                        offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                    }).onEnded({ value in
                        withAnimation { showPlot = false }
                    })
            )
        }
        .overlay(
            VStack(alignment: .leading) {
                let max = data.max() ?? 0
                Text("$ \(max, specifier: "%.2f")")
                    .font(.caption.bold())
                
                Spacer()
                
                Text("$ 0")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        )
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    func FillBG() -> some View {
        LinearGradient(colors: [.yellow.opacity(0.6), .yellow.opacity(0.1)],
                       startPoint: .top,
                       endPoint: .bottom)
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
