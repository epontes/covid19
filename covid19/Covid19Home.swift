//
//  Covid19Home.swift
//  covid19
//
//  Created by Eduardo Pontes on 31/05/20.
//  Copyright © 2020 Eduardo Pontes. All rights reserved.
//

import SwiftUI
import SwiftUICharts


struct Covid19Home: View {
    
    @State var show = false
    @State var showCountryList = false
    @State var bottomState = CGSize.zero
    @State var globalcases:  GlobalCases!
    @ObservedObject var store = CountryStore()
    
    private var data: [Int: [Int]] = [
        0: [28,25,30,29,23],
        1: [3,1,2,4,3],
        2: [2,6,8,3,3],
    ]
    private var daDeaths:  [Int] = [
          526352,
          530724,
           534166,
           537963,
           544070,
          549389,
          554847,
          560158,
         565051,
          569008,
        526352,
          578484,
          583977,
          589782,
        596519,
         602146,
          606175,
          610335,
          616578,
         623556,
        633522,
          639666,
       645262,
        648664,
         654055,
         660454,
       667120,
          673173,
         679439,
          685054
    ]
    
    @State var pickerSelectedItem = 0
    
    var detahs : [String: Int]  = ["7/19/20" : 14507589, "7/20/20": 14714367, "7/21/20" : 14947822]
    @State var txt = ""
    @State var datapicker: String  = "Data1"
    
  
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            
            ScrollView (showsIndicators: false ){
                
                GeometryReader{ geoReader  in
                    CardTitleView()
                        .offset(y: geoReader.frame(in: .global).minY > 0 ? -geoReader.frame(in: .global).minY : 0)
                }.frame(height: 350)
                
                GlobalCardView(store: self.store)
                    .offset(y: -150)
                    .padding(.bottom, -75)
                
                VStack(spacing: 10) {
                    
                   // CountryView()
                   
                    
                    
                    Picker(selection: $pickerSelectedItem, label: Text("")) {
                        Text("Recovered").tag(0)
                        Text("Active").tag(1)
                        Text("Death").tag(2)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal,25)
                        .foregroundColor(Color.white)
                    
                    
                    HStack  {
                        if self.pickerSelectedItem == 0 {
                            
                            Last7DaysComponent(values: self.store.last7Recovred, color: Color.green)
                        }
                        if self.pickerSelectedItem == 1{
                            
                            Last7DaysComponent(values: self.store.last7actived,color: Color.orange)
                            
                        }
                        if self.pickerSelectedItem == 2{
                            Last7DaysComponent(values: self.store.last7Deaths,color: Color.red)
                        }
                        
                    }
                    
                }
                
                VStack {
                    HStack {
                        Text("Last  do It")
                            .font(.system(size: 29, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(30)
                        .padding(.top, 30)
                }
                
                HStack(spacing: 2) {
                    
                    ForEach(self.daDeaths.indices) { i in
                        
                        HStack {
                            
                            Opa(maxValue: 685054 / 10000, valuePerPeriod: CGFloat(self.daDeaths[i] ) / 10000)
                        }
                    }.animation(.easeIn)
 
                }.frame(width: screen.width - 39)
                    .frame(height: 230)
                  .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                 .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                 .foregroundColor(.white)
                    
                   
                     
                
                
                
            }
            
        }.onAppear {
            self.store.getGlobalCases()
            self.store.getLast7GlobalDaysOfDeaths()
        }
        
    }
    
    
    
}

struct Opa: View {
    
    var maxValue: CGFloat
    var valuePerPeriod: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Spacer()
            Capsule()
                .frame(width: 9, height: maxValue * 1.56)
                .foregroundColor(Color.white.opacity(0.2))
            Capsule()
                .frame(width: 9, height: valuePerPeriod)
                .foregroundColor(.red)
                
        }
    }
}

struct Covid19Home_Previews: PreviewProvider {
    static var previews: some View {
        Covid19Home()
    //    Group {
            //                        Covid19Home()
            //                            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            //                            .previewDisplayName("iPhone SE")
            //
            //            Covid19Home()
            //                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
            //                .previewDisplayName("iPhone XS Max")
            
            
//            Covid19Home()
//                .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
//                .previewDisplayName("iPhone XR")
            //
            //                        Covid19Home()
            //                        .previewDevice(PreviewDevice(rawValue: "iPhone 7"))
            //                        .previewDisplayName("iPhone 7")
       // }
        
    }
}


let screen  = UIScreen.main.bounds


struct GlobalCardView: View {
    
    @ObservedObject var store = CountryStore()
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("World")
                        .font(.system(size: 24, weight: .bold))
                    
                    Spacer()
                    
                    Image("global-1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 54, height: 54)
                    
                    
                    
                }
                HStack {
                    HStack {
                        VStack(spacing: 15) {
                            Text("Affected")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("\(self.store.cases)")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        
                    }
                    .frame(width:(screen.width / 3) - 20, height: 150)
                    .background(Color(#colorLiteral(red: 0.9872558713, green: 0.6850754023, blue: 0.34358868, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    
                    HStack {
                        VStack(spacing: 15) {
                            Text("Recovered")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("\(self.store.recovered)")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        
                    }
                    .frame(width:(screen.width / 3) - 20, height: 150)
                    .background(Color(#colorLiteral(red: 0.2851912379, green: 0.822678268, blue: 0.4668182135, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    
                    HStack {
                        VStack(spacing: 15) {
                            Text("Deaths")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("\(self.store.deaths)")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        
                    }
                    .frame(width:(screen.width / 3) - 20, height: 150)
                    .background(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.85000002)))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }.frame(width: screen.width / 3)
                
                
                
                
                
                
            }.padding(30)
                .frame(width: screen.width, height: 270)
                .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .foregroundColor(.white)
                .offset(y: 90)
        }
        .frame(maxWidth: .infinity)
        .offset(y: -40)
    }
}

struct CardTitleView: View {
    var body: some View {
        VStack {
            
            Image("cardHome")
                
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(width: screen.width)
            
            Spacer()
        }
        
    }
}

struct CountryView: View {
    var body: some View {
        VStack {
            
            HStack {
                Text("Coutry")
                    .font(.system(size: 29, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
            }.padding()
            
            HStack {
                
                
                Text("Brazil")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                
                Image("br")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .frame(width: 60, height:60 )
                
            }
            
            
            
        }.padding(30)
            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            .frame(width: screen.width - 30)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct Last7DaysComponent: View {
    
    var values: [LastCases]!
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Last 7 Days")
                .font(.system(size: 19, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
            ForEach(values) {i in
                HStack {
                    Text("\(i.date)")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                    
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .fill(self.color)
                            .frame(width: 70 , height: 30)
                        
                        Text("\(i.deaths)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                        
                }.padding(10)
                
                
                Divider()
                    .background(Color.white)
            }
            
            
        }
        .padding(30)
        .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
        .frame(width: screen.width - 30)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}


extension  GradientColors {
    public static let red = GradientColor(start: Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.85000002)), end: Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.85000002)))
    
    public static let greenCustomized = GradientColor(start: Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)), end: Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)))
    
    public static let orangeCustomized = GradientColor(start: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)), end: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
}
