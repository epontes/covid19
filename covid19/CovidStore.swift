//
//  CovidStore.swift
//  covid19
//
//  Created by Eduardo Pontes on 08/06/20.
//  Copyright © 2020 Eduardo Pontes. All rights reserved.
//

import SwiftUI
import Combine

struct LastCases: Codable, Identifiable {
    var id =  UUID()
    var date: String =  ""
    var deaths: Int  =  0
}

class CountryStore: ObservableObject {
    @Published var country:  CountryModel?
    @Published var lastDeaths: [LastCases] = []
    @Published var selectCountry: String = ""
    @Published var cases: Int     = 0
    @Published var deaths: Int    = 0
    @Published var active: Int    = 0
    @Published var recovered: Int = 0
    @Published var critical: Int  = 0
    
    
    @Published var timeLine: [String: Int] = [:]
    
    
     
    
    
    
    func getGlobalCases() {
        API().getGlobalCases { (global) in
            self.cases      = global.cases
            self.active     = global.active
            self.deaths     = global.deaths
            self.recovered  = global.recovered
            self.critical   = global.critical
            
        }
    }
    func getCountry() {
        API().getCountryCases(name: self.selectCountry.lowercased()) { (countrCases) in
            self.cases      = countrCases.cases
            self.recovered  = countrCases.recovered
            self.critical   = countrCases.critical
            self.deaths     = countrCases.deaths
            self.active     = countrCases.active
            
            
        }
        
    }
    
    func getLastDays() {
        if self.selectCountry == "" { return }
        
        API().getDeathsDays(name: self.selectCountry.lowercased()) { (deathsMOTH) in
            
           self.timeLine    =  deathsMOTH.timeline["deaths"]!
            self.lastDeaths =  []
            
            for i in self.timeLine {
                self.lastDeaths.append(LastCases(date: i.key, deaths: i.value))
            }
            
            self.lastDeaths.sort{ (t, t1) -> Bool in
                if t.date < t1.date{
                    return false
                }else {
                    return true
                }
                
            }
        }
    }
}
 
