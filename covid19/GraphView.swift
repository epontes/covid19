//
//  GraphView.swift
//  covid19
//
//  Created by Eduardo Pontes on 22/06/20.
//  Copyright © 2020 Eduardo Pontes. All rights reserved.
//

import SwiftUI

struct GraphView: View {
    
    @ObservedObject var store = CountryStore()
    @State var pickerSelectedItem = 0
    @State var timeline : [[CGFloat]] = [
        
        [0,1,2,3,4,5,6,7],
        [8,16,32,40,48,56,64,72],
        [9,18,27,46,55,64,100,190]
       
    ]
    
    @State var dataPoints: [[CGFloat]] = [
       [ 1,2,3,4,5,6,200],
       [ 3,5,1,1,1,1,200],
       [200,10,40,150,200,200,200],

    ]
    var cases: [String: Int] = [:]
        
    var body: some View {
    
        ZStack {
            Color("secondary").edgesIgnoringSafeArea(.all)
            VStack {
                Text("Last 7 days")
                    .font(.system(size: 27, weight: .bold))
                    .foregroundColor(.white)
                
                Picker(selection: $pickerSelectedItem, label: Text("")) {
                    Text("Recovered").tag(0)
                    Text("Active").tag(1)
                    Text("Death").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal,25)
                
                
                HStack(spacing: 20) {
                    
                    
                    BarView(value: self.timeline[self.pickerSelectedItem][0])
                    BarView(value: self.timeline[self.pickerSelectedItem][1])
                    BarView(value: self.timeline[self.pickerSelectedItem][2])
                    BarView(value: self.timeline[self.pickerSelectedItem][3])
                    BarView(value: self.timeline[self.pickerSelectedItem][4])
                    BarView(value: self.timeline[self.pickerSelectedItem][5])
                    BarView(value: self.timeline[self.pickerSelectedItem][6])
 
                }.padding(.top, 10)
                    .animation(.easeOut)
            }
        }
    }
 
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}

struct BarView: View {
    var value: CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment:.bottom) {
                Capsule().frame(width: 15, height: 200)
                    .foregroundColor(.white)
                
                Capsule().frame(width: 15, height: value)
                    .foregroundColor(.red)
            }
        }
    }
}


