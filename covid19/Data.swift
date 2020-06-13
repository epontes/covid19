//
//  Data.swift
//  covid19
//
//  Created by Eduardo Pontes on 11/06/20.
//  Copyright © 2020 Eduardo Pontes. All rights reserved.
//

import SwiftUI

struct GlobalCases: Codable{
  var cases: Int
  var deaths: Int
  var recovered: Int
  var active: Int
  var critical: Int
  

}

struct TimeLine: Codable {
     var timeline : [String : [String : Int]]
    
}


class API  {
    func getGlobalCases(completion: @escaping (GlobalCases) -> () )  {
        guard let url = URL(string: "https://corona.lmao.ninja/v2/all?today") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            let global =  try! JSONDecoder().decode(GlobalCases.self, from: data!)
            DispatchQueue.main.sync {
                completion(global)
            }
        }
    .resume()
    }
    
    func getCountryCases(name: String, completion: @escaping (GlobalCases) -> () )  {
           guard let url = URL(string: "https://corona.lmao.ninja/v2/countries/\(name)/?yesterday=false") else {return}
           
           URLSession.shared.dataTask(with: url) { (data, _, _) in
               
               let global =  try! JSONDecoder().decode(GlobalCases.self, from: data!)
               DispatchQueue.main.sync {
                   completion(global)
               }
           }
       .resume()
        }
    
    
    func getDeathsDays(name: String, completion: @escaping (TimeLine) -> () )  {
        guard let url = URL(string: "https://disease.sh/v2/historical/\(name)?lastdays=10") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            let countryDeaths =  try! JSONDecoder().decode(TimeLine.self, from: data!)
            DispatchQueue.main.sync {
                completion(countryDeaths)
            }
        }
    .resume()
     }
}
