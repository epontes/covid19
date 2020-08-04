//
//  HomeView.swift
//  covid19
//
//  Created by Eduardo Pontes on 07/07/20.
//  Copyright © 2020 Eduardo Pontes. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct HomeView: View {
    
    var cases: Int
    var recovered: Int
    var deaths: Int
    
    var lastGlobalDeaths: [LastCases]
    
    var body: some View {
        
        
        
        ScrollView {
            VStack {
                
                HStack {
                    Text("Tracking")
                        .font(.system(size: 28, weight: .bold))
                    
                    Spacer()
                    
                }.padding(.horizontal)
                    .padding(.leading, 14)
                    .padding(.top, 30)
                
                SectionView(cases: self.cases, recovered: self.recovered, deaths: self.deaths, deathLat7: self.lastGlobalDeaths)
                    .offset(y: -10)
                
                HStack {
                      Text("Countries")
                          .font(.system(size: 28, weight: .bold))
                      
                      Spacer()
                  }.padding(.leading, 30)
                ScrollView(.horizontal, showsIndicators: false) {
                   
                    
                        
                    HStack {
                        
                        HStack {
                            Text("BRAZIL")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image("br")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                        }.padding(30)
                            .frame(width: 200, height: 170)
                            .background(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                            .cornerRadius(30)
                            .shadow(color: Color(#colorLiteral(red: 0.1211629882, green: 0.148221761, blue: 0.2297588885, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                            .padding(30)
                        
                        HStack {
                            Text("UNITED")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image("us")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                        }.padding(30)
                            .frame(width: 200, height: 170)
                            .background(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                            .cornerRadius(30)
                            .shadow(color: Color(#colorLiteral(red: 0.1211629882, green: 0.148221761, blue: 0.2297588885, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                            .padding(30)
                    }
                    
                    
                }
                
                
                Spacer()
                
            }
        }
        
    }
    func getLineChartData(deaths: [LastCases]) -> [Double] {
        
        var values: [Double] = []
        
        for v in deaths {
            values.append(Double(v.deaths))
        }
        return values.sorted()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(cases: 0, recovered: 0, deaths: 0, lastGlobalDeaths: .init())
    }
}

struct SectionView: View {
    
    var cases: Int
    var recovered: Int
    var deaths: Int
    
    var deathLat7: [LastCases]
    
    var body: some View {
        VStack {
            
            HStack{
                Text("Global")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image("global-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    
                    .overlay(Circle().stroke(Color.white, lineWidth: 3)
                )
                    .frame(width: 34, height: 34)
                
                
            }
            
            Divider().background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.3))
            
            HStack(spacing: 31) {
                VStack(spacing: 10) {
                    Text("Infected")
                        .font(.system(size: 17, weight: .bold))
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    
                    Text("\(cases)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 10) {
                    Text("Recovered")
                        .font(.system(size: 16, weight: .bold))
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    
                    Text("\(recovered)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 10) {
                    Text("Deaths")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    
                    Text("\(deaths)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                }
                
            }.padding()
                .padding(.top, 20)
                .background(Color(#colorLiteral(red: 0.125174433, green: 0.1520421505, blue: 0.2378802598, alpha: 1)))
                .clipShape(Rectangle())
                .overlay(Rectangle().stroke(Color(#colorLiteral(red: 0.125174433, green: 0.1520421505, blue: 0.2378802598, alpha: 1)).opacity(0.2), lineWidth: 4))
                .frame(width: 310)
            
            
            
        }.padding(30)
            .padding(.horizontal)
            .frame(width: 375, height: 370)
            .background(Color(#colorLiteral(red: 0.1211629882, green: 0.148221761, blue: 0.2297588885, alpha: 1)))
            .cornerRadius(30)
            .shadow(color: Color(#colorLiteral(red: 0.1211629882, green: 0.148221761, blue: 0.2297588885, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
            .padding(30)
    }
    
    func getLineChartData(deaths: [LastCases]) -> [Double] {
        
        var values: [Double] = []
        
        for v in deaths {
            values.append(Double(v.deaths))
        }
        return values.sorted()
    }
    
    func  getHeight(value : Int, height: CGFloat)->CGFloat{
        
        let max  = self.deathLat7.max {a,b in a.deaths < b.deaths}?.deaths ?? 0
        
        let converted  = (CGFloat(value) / CGFloat(max) * 100)
        
        print(converted * height)
        print(value)
        
        return  converted * height
        
    }
}


