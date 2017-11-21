//
//  Constants.swift
//  LineChartExample
//
//  Created by Jemal Aytjanova on 11/19/17.
//  Copyright © 2017 Osian. All rights reserved.
//

import Foundation

var arr:[String]?

func saveData(arr:[String]){
    
    UserDefaults.standard.set(arr, forKey: "arr")
}

func fetchData() -> [String]?{
    if let lst = UserDefaults.standard.array(forKey: "arr") as? [String]{
        return lst
    }
    else{
        return nil
    }
}
