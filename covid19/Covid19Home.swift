//
//  Covid19Home.swift
//  covid19
//
//  Created by Eduardo Pontes on 31/05/20.
//  Copyright © 2020 Eduardo Pontes. All rights reserved.
//

import SwiftUI


struct Covid19Home: View {
    
    @State var show = false
    @State var bottomState = CGSize.zero
    @State var globalcases:  GlobalCases!
    @ObservedObject var store = CountryStore()
    var body: some View {
        ZStack {
            
            Color(#colorLiteral(red: 0.2705882353, green: 0.2588235294, blue: 0.5725490196, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
          TitleView(store: self.store)
                    .blur(radius: show  ? 20 : 0)
                    .animation(.default)
                    
    
                VStack {
                    InfoMation(cases: self.store.cases, deaths: store.deaths)
                        .padding(.top, 14)
                        .foregroundColor(Color.white)
                        .padding(.bottom,10)
                        .onTapGesture {
                            self.show.toggle()
                            
                            if self.show == true {
                                self.store.getLastDays()
                            }
                            
                    }
                    
                    
                    TrackingMiddleInfo(recovered: self.store.recovered,
                                       actived:   self.store.active,
                                       srious: self.store.critical )
                        .padding(.top, 10)
                        .foregroundColor(.white)
  
                    Spacer()
                }
                .padding(.top, 100)
                
                
            BottomView(store: self.store)
                    .offset(x: 0, y: show ? 540 : 1000)
                    .offset(y: bottomState.height)
                    .blendMode(.hardLight)
                    //.blur(radius: show ? 20 : 0)
                    .animation(.default)
                    .gesture(
                        DragGesture().onChanged { value in
                            self.bottomState = value.translation
                        }
                        .onEnded { value in
                            self.bottomState = .zero
                        }
                )
              
   
        }.onAppear {
            API().getGlobalCases { (casesGlobal) in
                self.store.active = casesGlobal.active
                self.store.deaths = casesGlobal.deaths
                self.store.recovered = casesGlobal.recovered
                self.store.cases = casesGlobal.cases
                self.store.critical = casesGlobal.critical
            }
        }
        
    }
        
   
    
}

struct Covid19Home_Previews: PreviewProvider {
    static var previews: some View {
        Covid19Home()
    }
}


let screen  = UIScreen.main.bounds

struct TitleView: View {
    @State var showCountryList = false
    @ObservedObject var store = CountryStore()
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Covid Tracking")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {self.showCountryList.toggle()} ) {
                        Image(store.selectCountry.lowercased())
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    }
                    .sheet(isPresented: $showCountryList) {
                        CountryList(store: self.store)
                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

struct TrackingMiddleInfo: View {
    
    var recovered: Int
    var actived: Int
    var srious: Int
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(spacing: 13) {
                Text("Recovered")
                    .fontWeight(.bold)
                
                Text("\(recovered)")
                    .fontWeight(.bold)
            }
            .padding(.vertical)
            .frame(width: (screen.width / 3) - 30)
            .background(Color(#colorLiteral(red: 0.2953642607, green: 0.8506259918, blue: 0.4809744954, alpha: 1)))
            .cornerRadius(12)
            
            VStack(spacing: 13){
                Text("Active")
                    .fontWeight(.bold)
                Text("\(actived)")
                    .fontWeight(.bold)
            }
            .padding(.vertical)
            .frame(width: (screen.width / 3) - 30)
            .background(Color(#colorLiteral(red: 0.2972684801, green: 0.7089626193, blue: 1, alpha: 1)))
            .cornerRadius(12)
            
            VStack(spacing: 13){
                Text("Serious")
                    .fontWeight(.bold)
                Text("\(srious)")
                    .fontWeight(.bold)
            }
            .padding(.vertical)
            .frame(width: (screen.width / 3) - 30)
            .background(Color(#colorLiteral(red: 0.5642444491, green: 0.349326551, blue: 0.9994863868, alpha: 1)))
            .cornerRadius(12)
        }
        
    }
}

struct InfoMation: View {
    var cases: Int
    var deaths: Int
    var body: some View {
        HStack(spacing: 15) {
            VStack(spacing: 12) {
                Text("Affected")
                    .fontWeight(.bold)
                
                Text("\(cases)")
                    .font(.system(size: 20, weight: .bold))
                    
                
                
            }
            .padding(.vertical,70)
            .frame(width: (UIScreen.main.bounds.width / 2) - 30)
            .background(Color(#colorLiteral(red: 0.9568627451, green: 0.7058823529, blue: 0.4117647059, alpha: 1)))
            .cornerRadius(10)
            
            
            
            VStack(spacing: 12) {
                Text("Death")
                    .fontWeight(.bold)
                
                Text("\(deaths)")
                    .font(.system(size: 20, weight: .bold))
                    
                
                
            }
            .padding(.vertical, 70)
            .frame(width: (UIScreen.main.bounds.width / 2) - 30)
            .background(Color(#colorLiteral(red: 0.9294117647, green: 0.3960784314, blue: 0.3725490196, alpha: 1)))
            .cornerRadius(10)
            
            
            
        }
        
        
    }
}

struct BottomView: View {
    
    @ObservedObject var store = CountryStore()
    
    var body: some View {
        VStack(spacing: 20){
            
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3.5)
                .opacity(0.1)
            
            HStack {
                Text("\(store.selectCountry)")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineSpacing(4)
                
                Spacer()
                
                Image(systemName: "flag")
                    .renderingMode(.original)
                    .frame(width: 36, height: 36)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
                
            }
           
            ForEach(self.store.lastDeaths) {  death in
                HStack {
                    Text("\(death.date)")
                    
                    Spacer()
     
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.9993320107, green: 0.2969099283, blue: 0.3465870023, alpha: 1)))
                        .frame(width: 10, height: 10)
                    Text("\(death.deaths)")
                    
                }
                Divider()
            }
            
            
            
            Spacer()
        }
        .padding()
        .padding(.horizontal,20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
         
    }
}




 
 
 

