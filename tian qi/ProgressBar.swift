//
//  ProgressBar.swift
//  tian qi
//
//  Created by bochain on 2023/8/3.
//

import SwiftUI

struct ProgressBar: View {
    var MaxT: Int
    var minMaxT: Int
    var maxMaxT: Int
    var MinT: Int
    var maxMinT: Int
    var minMinT: Int
    
    
    var body: some View {
        
        HStack {
            //MinT
            ZStack(alignment: .bottomTrailing){
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 60, height: 10)
                    .overlay(
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 10, height: 10)
                            .cornerRadius(10)
                            .offset(x: -30, y: 0)
                        // Adjust the offset based on your desired position
                    )
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: CGFloat(60*(maxMinT - MinT)/(maxMinT - minMinT)), height: 10)
                    .overlay(
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .cornerRadius(20)
                            .offset(x: CGFloat(-30*(maxMinT - MinT)/(maxMinT - minMinT)), y: 0)
                        // Adjust the offset based on your desired position
                    )
            }
            //MaxT
            ZStack(alignment: .bottomLeading){
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 60, height: 10)
                    .overlay(
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 10, height: 10)
                            .cornerRadius(10)
                            .offset(x: 30, y: 0)
                        // Adjust the offset based on your desired position
                    )
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: CGFloat(10+70*(MaxT - minMaxT)/(maxMaxT - minMaxT)), height: 10)
                    .overlay(
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .cornerRadius(10)
                            .offset(x: CGFloat(10+30*(MaxT - minMaxT)/(maxMaxT - minMaxT)), y: 0)
                        // Adjust the offset based on your desired position
                    )
                    .offset(x:-10,y:0)
            }
        }
        .padding()
    }
    
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(
            //MaxT
            MaxT: 32,
            minMaxT: 30,
            maxMaxT: 35,
            
            MinT: 25,
            maxMinT: 29,
            minMinT: 23
        )
    }
}
