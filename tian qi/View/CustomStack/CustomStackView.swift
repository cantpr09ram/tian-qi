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
    //offet
    @State var topOffset: CGFloat = 0
    @State var bottomOffet: CGFloat = 0
    
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
                                CoustomCorner(corners: bottomOffet < 60 ? .allCorners : [.topLeft, .topRight], radius: 12))
                .zIndex(1)
            
            VStack{
                Divider()
                contentView
                    
                    
            }
            .background(.ultraThinMaterial, in:
                CoustomCorner(corners: [.bottomLeft, .bottomRight], radius: 12))
            //moving centent upward
            .offset(y: topOffset >= 120 ? 0:-(-topOffset + 120))
            .zIndex(0)
            //cipping to avoid background overlay
            .clipped()
            .opacity(getOpacty())
        }
        .padding()
        .colorScheme(.dark)
        .cornerRadius(12)
        .opacity(getOpacty())
        //stopping view @120
        .offset(y: topOffset >= 120 ? 0:-topOffset + 120)
        .background(
            GeometryReader{proxy -> Color in
            let minY = proxy.frame(in: .global).minY
            let maxY = proxy.frame(in: .global).maxY
            
            DispatchQueue.main.async {
                self.topOffset = minY
                self.bottomOffet = maxY - 120
            }
            return Color.clear
            }
        )
        .modifier(CornerModifier(bottomOffset: $bottomOffet))
    }
    //opacty
    func getOpacty() ->CGFloat{
        if bottomOffet < 70{
            let progress = bottomOffet / 70
            
            return progress
        }
        return 1
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
            .padding()
        }
    }
}

struct CornerModifier : ViewModifier{
    
    @Binding var bottomOffset: CGFloat
    
    func body(content: Content) -> some View {
        if bottomOffset < 70 {
            content
        }else{
            content
                .cornerRadius(12)
        }
    }
}
