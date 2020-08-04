//
//  GraphCharts.swift
//  covid19
//
//  Created by Eduardo Pontes on 22/07/20.
//  Copyright © 2020 Eduardo Pontes. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct GraphCharts: View {
    @State var title: String
    @State var datas: [Double]
    
    var body: some View {
        HStack {
            LineView(data: datas, title: self.title)
            }.padding(30)
            .frame(maxWidth: .infinity)
            
    }
}

struct GraphCharts_Previews: PreviewProvider {
    static var previews: some View {
        GraphCharts(title: "Last 7 days", datas: [75366,76688,77851,78772,79488,80120,81487])
    }
}
