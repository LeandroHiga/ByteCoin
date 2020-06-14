//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    //Create delegate variable (ViewController will be set as this delegate)
    var delegate: CoinManagerDelegate?
    
    //Base URL
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    //My API key
    let apiKey = "A5C16B2D-C058-451A-9D8F-A02375717866"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    //Fetch value based on entered currency
    func getCoinPrice(for currency: String) {
        //Add selected currency and key to the URL
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    //Networking that fetch live data from CoinAPI
    func performRequest(with urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create URL Session
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                //Check if there is an error
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    //If there is an error, exit out of the function
                    return
                }
                //Check if data is nil
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCurrency(self, coin: coin)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    
    //Parse currency into a Swift object
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            //Use CoinData
            let quote = decodedData.asset_id_quote   //Quote
            let rate = decodedData.rate              //Rate

            //Create coin object
            let coin = CoinModel(quote: quote, rate: rate)
            return coin
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
