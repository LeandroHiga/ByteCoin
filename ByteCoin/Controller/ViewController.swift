//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    //Create new Coin Manager
    var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set this class (ViewController) as the delegate for coinManager
        coinManager.delegate = self
        //Set this class (ViewController) as the datasource to the currencyPicker
        currencyPicker.dataSource = self
        //Set this class (ViewController) as the delegate for currencyPicker
        currencyPicker.delegate = self
        
    }

}

//MARK: - UIPickerViewDelegate / UIPickerViewDataSource

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //Number of columns we want for in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Number of rows we want in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    //Title for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    //Function called by the picker when user selects a row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel) {

        //Use of DispatchQueue
        DispatchQueue.main.async {
            //Updata labels
            self.currencyLabel.text = coin.quote
            self.bitcoinLabel.text = coin.rateString
        }
    }
    
    func didFailWithError(error: Error) {
        //Print error if any
        print(error)
    }
    
}

