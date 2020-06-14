//
//  CoinData.swift
//  ByteCoin
//
//  Created by Lean Caro on 14/06/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    
    //Properties based on json
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
