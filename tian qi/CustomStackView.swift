//
//  CustomStackView.swift
//  tian qi
//
//  Created by bochain on 2023/8/2.
//

import SwiftUI

struct CustomStackView<Title: View, Content: View>: View {
    
    var titleView : Title
    var contentView: Content
    
    init(@ViewBuilder titleView: @escaping ()->Title, @ViewBuilder contentView: @escaping ()->Content) {
        self.titleView = titleView()
        self.contentView = contentView()
    }
    
    var body: some View {
        VStack(spacing: 0){
            titleView
                .font(.callout)
                .lineLimit(1)
                .frame(height: 38)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .background(.ultraThinMaterial, in:
                        CoustomCorner(corners: [.topLeft, .topRight], radius: 12))
            
            VStack{
                Divider()
                contentView
                    
                    
            }
            .background(.ultraThinMaterial, in:
                CoustomCorner(corners: [.bottomLeft, .bottomRight], radius: 12))
            
        }
        .colorScheme(.dark)
        .padding()
    }
}

struct CustomStackView_Previews: PreviewProvider {
    static var previews: some View {
        CustomStackView{
            Label{
                Text("hello world")
            }icon: {
                Image(systemName: "clock")
            }
        }contentView: {
            VStack{
                Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
            }
        }
    }
}
