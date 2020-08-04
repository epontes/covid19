//
//  CountryList.swift
//  covid19
//
//  Created by Eduardo Pontes on 08/06/20.
//  Copyright © 2020 Eduardo Pontes. All rights reserved.
//

import SwiftUI

struct CountryList: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var store = CountryStore()
    
    @State var searchText = ""
    var body: some View {
        NavigationView {
            
            List {
                HStack {
                    
                    TextField("Search by Country", text: self.$searchText)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 10)
                            }
                        )
                        .padding(.horizontal, 10)
                        
                    
                    
                }
                ForEach(countries.filter({searchText.isEmpty ? true : $0.name.contains(searchText)})) { country in
  
                        HStack {
                           
                            Image("\(country.image)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 99)
                                .background(Color.black)
                                .cornerRadius(10)
                                .padding(.trailing, 4)
                            
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text("\(country.name)")
                                    .font(.system(size: 20, weight: .bold))
                                
                                Text("\(country.iso2)")
                                    .font(.subheadline)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            }
                        }.onTapGesture {
                              self.goTohome(country: country)
                              self.presentationMode.wrappedValue.dismiss()
                              
                    }
                     
                }
            }.navigationBarTitle("Countries")
        }
        
    }
    func goTohome(country: CountryModel) {
        self.store.selectCountry = country.iso2
        self.store.getCountry()
    }
    
}


struct CountryList_Previews: PreviewProvider {
    static var previews: some View {
        CountryList()
    }
}

struct CountryModel: Identifiable {
    var id = UUID()
    var iso2: String
    var iso3: String
    var name: String
    var image: String
    

    init(iso2: String, iso3: String, name: String, image: String) {
        self.iso2  = iso2
        self.iso3  = iso3
        self.name  = name
        self.image = image
    }
    
}

let countries = [
    CountryModel(iso2: "BR", iso3: "BRA", name: "Brazil", image: "br"),
    CountryModel(iso2: "US", iso3: "USA", name: "United States", image: "us"),
    CountryModel(iso2: "PT", iso3: "PRT", name: "Portugal", image: "pt"),
    CountryModel(iso2: "IT", iso3: "ITA", name: "Italy", image: "it"),
    CountryModel(iso2: "ES", iso3: "Spain", name: "Spain", image: "es"),
    CountryModel(iso2: "GB", iso3: "GBR", name: "Inglaterra", image: "gb"),
    
    CountryModel(iso2: "AR", iso3: "ARG", name: "Argentina", image: "ar"),
    
     CountryModel(iso2: "CL", iso3: "CHL", name: "Chile", image: "cl"),
    
     CountryModel(iso2: "CO", iso3: "COL", name: "Colombia", image: "co")
]
    
