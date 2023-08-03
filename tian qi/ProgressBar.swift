//
//  ProgressBar.swift
//  tian qi
//
//  Created by bochain on 2023/8/3.
//

import SwiftUI

struct ProgressBar: View {
    var body: some View {
        HStack {
            //MaxT
            ZStack(alignment: .bottomTrailing){
                Rectangle()
                    .frame(width: 70, height: 20)
                    .overlay(
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: 20, height: 20)
                            .cornerRadius(20)
                            .offset(x: -35, y: 0)
                        // Adjust the offset based on your desired position
                    )
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 50, height: 20)
                    .overlay(
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 20, height: 20)
                            .cornerRadius(20)
                            .offset(x: -25, y: 0)
                        // Adjust the offset based on your desired position
                    )
            }
            //MinT
            ZStack(alignment: .bottomLeading){
                Rectangle()
                    .frame(width: 70, height: 20)
                    .overlay(
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: 20, height: 20)
                            .cornerRadius(20)
                            .offset(x: 35, y: 0)
                        // Adjust the offset based on your desired position
                    )
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 30, height: 20)
                    .overlay(
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 20, height: 20)
                            .cornerRadius(20)
                            .offset(x: 15, y: 0)
                        // Adjust the offset based on your desired position
                    )
                    .offset(x:-10,y:0)
            }
        }
        .padding()
    }
    
    struct ProgressBar_Previews: PreviewProvider {
        static var previews: some View {
            ProgressBar()
        }
    }
}
