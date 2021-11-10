//
//  ContentView.swift
//  PowerCalculator
//
//  Created by Joe McDonald on 8/29/21.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label
      Spacer()
    }
    .padding()
    .background(Color(UIColor.secondarySystemBackground).cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct ContentView: View {
    
    @State private var map = "28.8"
    @State private var fmap: Float = 0
    @State private var rpm = "2700"
    @State private var frpm: Float = 0
    @State private var oat = "59"
    @State private var foat: Float = 0
    @State private var alt = "0"
    @State private var falt: Float = 0
    @State private var baro = "29.92"
    @State private var fbaro: Float = 0
    
    @State private var rmap = "28.8"
    @State private var frmap: Float = 0
    @State private var rrpm = "2700"
    @State private var frrpm: Float = 0
    @State private var rhp = "285"
    @State private var frhp: Float = 0
    @State private var rqnh = "1013"
    @State private var frqnh: Float = 0
    @State private var engconst1 = "1.12110846301323"
    @State private var fengconst1: Float = 0
    @State private var engconst2 = "1.09205984451527"
    @State private var fengconst2: Float = 0
    @State private var engconst3 = "-0.79999999911006"
    @State private var fengconst3: Float = 0
    @State private var rlop = "13.5"
    @State private var frlop: Float = 0
    
    @State private var percenthp: Int = 0
    @State private var actualhp: Int = 0
    
    func convertValues() {
        fmap = Float(map) ?? 0
        frpm = Float(rpm) ?? 0
        foat = Float(oat) ?? 0
        falt = Float(alt) ?? 0
        fbaro = Float(baro) ?? 0
        
        frmap = Float(rmap) ?? 0
        frrpm = Float(rrpm) ?? 0
        frhp = Float(rhp) ?? 0
        frqnh = Float(rqnh) ?? 0
        fengconst1 = Float(engconst1) ?? 0
        fengconst2 = Float(engconst2) ?? 0
        fengconst3 = Float(engconst3) ?? 0
        frlop = Float(rlop) ?? 0
    }
    
    func calcHp() {
        convertValues()
        
        let qnh: Int = Int(fbaro * 33.865)
        let altp2: Float = pow(falt, 2)
        let pabs: Int = Int(((0.00000001187*altp2)-(0.001052*falt)+29.92)*33.865)
        let percent: Float = pow((((frmap-((frmap-fmap)*fengconst1))/frmap)*frpm/frrpm),fengconst2) * ((1+fengconst3)*(Float(qnh)/Float(pabs))-fengconst3) * sqrt(((519-3.58*falt/1000)/(460+foat)))
        percenthp = Int(100*percent)
        actualhp = Int(frhp*percent)
    }
    
    var body: some View {
        TabView(selection: .constant(1)) {
            VStack{
                HStack{
                    Text("Manifold Pressure:")
                    Spacer()
                    TextField("Manifold Pressure", text: $map)
                        .frame(width: 150)
                        .keyboardType(.decimalPad)
                }.padding([.leading, .bottom, .trailing])
                HStack{
                    Text("RPM:")
                    Spacer()
                    TextField("RPM", text: $rpm)
                        .frame(width: 150)
                        .keyboardType(.numberPad)
                }.padding([.leading, .bottom, .trailing])
                HStack{
                    Text("Altitude:")
                    Spacer()
                    TextField("Altitude", text: $alt)
                        .frame(width: 150)
                        .keyboardType(.numberPad)
                }.padding([.leading, .bottom, .trailing])
                HStack{
                    Text("Baro:")
                    TextField("Altitude", text: $baro)
                        .frame(width: 75)
                        .keyboardType(.decimalPad)
                    Text("OAT:")
                    TextField("OAT", text: $oat)
                        .frame(width: 75)
                        .keyboardType(.numberPad)
                }.padding([.leading, .bottom, .trailing])
                Button("Calculate", action: calcHp)
                    .padding()
                    .buttonStyle(RoundedRectangleButtonStyle())
                HStack{
                    Text(String(actualhp) + " HP").padding()
                    Text(String(percenthp) + "%").padding()
                }.font(.title)
            }
            .tabItem {
                Image(systemName: "function")
                Text("Calculator")
            }
            .tag(1)
            
            VStack{
                HStack{
                    Text("Rated Manifold Pressure:")
                    Spacer()
                    TextField("Rated Manifold Pressure", text: $rmap)
                        .frame(width: 100.0)
                        .keyboardType(.numberPad)
                }.padding([.leading, .bottom, .trailing])
                HStack{
                    Text("Rated RPM:")
                    Spacer()
                    TextField("Rated RPM", text: $rrpm)
                        .frame(width: 100.0)
                        .keyboardType(.numberPad)
                }.padding([.leading, .bottom, .trailing])
                HStack{
                    Text("Rated HP:")
                    Spacer()
                    TextField("Rated HP", text: $rhp)
                        .frame(width: 100.0)
                        .keyboardType(.numberPad)
                }.padding([.leading, .bottom, .trailing])
                HStack{
                    Text("LOP Constant:")
                    Spacer()
                    TextField("LOP Constant", text: $rlop)
                        .frame(width: 100)
                        .keyboardType(.numberPad)
                }.padding([.leading, .bottom, .trailing])
                HStack{
                    Text("Engine Constant 1:")
                    Spacer()
                    TextField("Engine Constant 1", text: $engconst1)
                        .frame(width: 200)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }.padding([.leading, .bottom, .trailing])
                HStack{
                    Text("Engine Constant 2:")
                    Spacer()
                    TextField("Engine Constant 2", text: $engconst2)
                        .frame(width: 200)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }.padding([.leading, .bottom, .trailing])
                HStack{
                    Text("Engine Constant 3:")
                    Spacer()
                    TextField("Engine Constant 3", text: $engconst3)
                        .frame(width: 200)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }.padding([.leading, .bottom, .trailing])
                
            }.tabItem {
                Image(systemName: "gear")
                Text("Settings")
                
            }.tag(2)
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPad Air (4th generation)")
                
        }
            
            
    }
}
