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
    @Published var lastDeaths: [LastCases]    = []
    @Published var last7Recovred: [LastCases] = []
    @Published var last7actived: [LastCases]  = []
    @Published var last7Deaths: [LastCases]   = []
    
    @Published var selectCountry: String = ""
    @Published var cases: Int     = 0
    @Published var deaths: Int    = 0
    @Published var active: Int    = 0
    @Published var recovered: Int = 0
    @Published var critical: Int  = 0
    
    
    @Published var timeLine: [String: Int] = [:]
    @Published var testeA: [String: Int]  = [:]
    
    @Published var deathsLast7Days: [String: Int] = [:]
    @Published var recoveredLast7Days: [String: Int] = [:]
    @Published var activeLast7Days: [String: Int] = [:]
    
    @Published var chartView: [Int] = []

    
    
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
                if t.deaths > t1.deaths{
                    return true
                }else {
                    return false
                }

            }
        
        }
    }
    
    func getLast7GlobalDaysOfDeaths() {
        
        API().getLast7GlobalDeathDays{ (lastDeaths) in
            
            let last7Deaths    =   lastDeaths["deaths"]!
            let last7Cases    =   lastDeaths["cases"]!
            let last7Recovered =   lastDeaths["recovered"]!
            
            self.lastDeaths = []
            
            for d in last7Deaths {
                self.last7Deaths.append(LastCases(date: d.key, deaths: d.value))
            }
            
            for c in last7Cases {
                self.last7actived.append(LastCases(date: c.key, deaths: c.value))
            }
            
            for r in last7Recovered {
                self.last7Recovred.append(LastCases(date: r.key, deaths: r.value))
             }
            

              self.last7Deaths.sort{ (t, t1) -> Bool in
                  if t.deaths > t1.deaths{
                      return true
                  }else {
                      return false
                  }

            }
            
            self.last7actived.sort{ (t, t1) -> Bool in
                  if t.deaths > t1.deaths{
                      return true
                  }else {
                      return false
                  }

            }
            
            self.last7Recovred.sort{ (t, t1) -> Bool in
                  if t.deaths > t1.deaths{
                      return true
                  }else {
                      return false
                  }

            }
                
        }
    }
}
 
