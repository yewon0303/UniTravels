//
//  CurrencyExchangeVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 24/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class CurrencyExchangeVC: UIViewController {
    
    //MARK: ~Properties
    var exchangeRates = [String]()
    
    @IBOutlet weak var baseTextField: UITextField!
    
    @IBOutlet weak var currencyTextField: UITextField!
    
    @IBOutlet weak var OutputLabel: UILabel!
    
    //MARK: ~Actions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func returnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findRate(_ sender: Any) {
        getRatesFor(base: baseTextField.text, currencies: [currencyTextField.text ?? ""]) { [weak self] (result) in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let response):
                    
                    self?.exchangeRates.removeAll(keepingCapacity: false)
                    
                    self?.title = response.date
                    
                    let keys = response.rates.keys.sorted()
                    
                    for key in keys {
                        
                        guard let value = response.rates[key] else { continue }
                        
                        self?.exchangeRates.append("1 \(response.base) = \(value) \(key)")
                        self!.OutputLabel.text = "1 \(response.base) = \(value) \(key)"
                    }
                    
                case .failure(let networkError):
                    
                    switch networkError {
                        
                    case .invalidUrl: print("Invalid Url")
                        
                    case .decodingFailed: print("Decoding failed")
                        
                    case .requestFailed: fallthrough
                        
                    @unknown default: print("Request failed")
                    }
                }
            }
        }
        
        
    }
    
    
    @IBAction func detailsTapped(_ sender: Any) {
        performSegue(withIdentifier: "currencyDetails", sender: self)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
