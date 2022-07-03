//
//  ContentView.swift
//  ShadeBox
//
//  Created by Isaac Raval on 7/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: -10) {
                ShadeBox(primaryColor: Color("lightBlue"), secondaryColor: Color("darkBlue"), rectColor: .blue)
                
                ShadeBox(primaryColor: Color("lightRed"), secondaryColor: Color("darkRed"), rectColor: .red)
                
                ShadeBox(primaryColor: Color("darkBlue"), secondaryColor: Color("darkBlue"), rectColor: .blue, leftButtonColor: Color("darkRed"))
                
                ShadeBox(primaryColor: Color("darkRed"), secondaryColor: Color("darkRed"), rectColor: .red)
            }
            .padding(.bottom, 20)
        }
    }
}

struct ShadeBox: View {
    @State var isTapped: Bool = false
    var primaryColor: Color
    var secondaryColor: Color
    var rectColor: Color
    var leftButtonColor: Color?
    var rightButtonColor: Color?
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(primaryColor)
                .frame(width: 300, height: 200)
                .cornerRadius(15)
            
            Rectangle()
                .foregroundColor(secondaryColor)
                .frame(width: 300, height: 170)
                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                .padding(.top, 70)
            
            TopRow(cubeColor: rectColor)
                .padding(.bottom, 150)
                .padding(.trailing, 130)
            
            TextBody(text: "Lorem ipsum dolor sit amet, quo amet dictas te, pri vocibus intellegam definitiones cu. At pro propriae probatus posidonium, rebum perpetua vel ei. Erant constituam vel et, ea modus diceret vocibus eam.")
                .frame(width: 270, height: 100, alignment: .leading)
                .padding(.trailing, 5)
                .padding(.top, 20)
            
            HStack(spacing: 14) {
                ButtonView(label: "Label", image: Image(systemName: "location.viewfinder"), color: leftButtonColor == nil ? primaryColor : leftButtonColor!, action: {})
                
                ButtonView(label: "Label", image: Image(systemName: "viewfinder.circle.fill"), color: rightButtonColor == nil ? primaryColor : rightButtonColor!, action: {})
            } .padding(.top, 170)
        }
        .scaleEffect(isTapped ? 0.9 : 1)
        .animation(.interpolatingSpring(mass: 1, stiffness: 1, damping: 0.5, initialVelocity: 10), value: 45)
        .onTapGesture {
            isTapped.toggle()
            withAnimation(Animation.default.delay(0.1)) {
                isTapped.toggle()
            }
        }
    }
}

struct TopRow: View {
    var cubeColor: Color
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(cubeColor)
                .frame(width: 30, height: 30, alignment: .leading)
                .foregroundColor(Color.blue)
                .cornerRadius(5)
            
            VStack(alignment: .leading) {
                Text("Text").bold().foregroundColor(.white)
                Text("SOME SUBTITLE")
                    .foregroundColor(.white)
                    .opacity(0.5)
                    .font(.system(size: 13, weight: .bold, design: .default))
            }
        }
    }
}

struct TextBody: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .opacity(0.5)
            .font(.system(size: 13, weight: .bold, design: .default))
    }
}

struct ButtonView: View {
    var label: String
    var image: Image
    var color: Color
    var action: (() -> Void)
    var body: some View {
        Button(action: {
            action()
        }, label: {
            ZStack {
                Rectangle()
                    .foregroundColor(color)
                    .frame(width: 130, height: 40)
                    .cornerRadius(15)
                
                HStack {
                    image
                    Text(label)
                }
            }
        })
        .foregroundColor( color == Color("lightBlue") ? nil : Color.white.opacity(0.7))
    }
}

//Helper (https://stackoverflow.com/questions/56760335/round-specific-corners-swiftui)
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

