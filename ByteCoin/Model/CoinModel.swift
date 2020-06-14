//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Lean Caro on 13/06/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {

    //Properties that will then use for update UI labels (in didUpdateCurrency)
    let quote: String
    let rate: Double
    
    //Computed property (convert rate to a String with 2 decimal places
    var rateString: String {
        let rateAsString = String(format: "%.2f", rate)
        return rateAsString
    }
    
}
