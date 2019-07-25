//
//  CurrencyExchangeVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 24/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import TweeTextField
import UIKit

class CurrencyExchangeVC: UIViewController {
    
    //MARK: ~Properties
    
    @IBOutlet weak var baseTextField: TweeAttributedTextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var OutputLabel: UILabel!
    @IBOutlet weak var inputAmount: UITextField!
    
    //MARK: ~Actions

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func returnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findRate(_ sender: Any) {
        getRatesFor(base: baseTextField.text, currencies: [currencyTextField.text ?? ""]) { [weak self] (result) in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let response):
                    
                    let keys = response.rates.keys.sorted()
                    
                    for key in keys {
                        
                        guard let value = response.rates[key] else { continue }

                        let input: Double = Double(self!.inputAmount.text!) ?? 1.0
                        
                        self!.OutputLabel.text = "\(input) \(response.base) = \(value * input) \(key)"
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


}
