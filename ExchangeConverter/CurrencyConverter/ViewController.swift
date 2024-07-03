//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Mert Erciyes Çağan on 6/4/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var GBPLabel: UILabel!
    @IBOutlet weak var TRYLabel: UILabel!
    @IBOutlet weak var USDLabel: UILabel!
    @IBOutlet weak var CADLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getCurrencies(_ sender: Any) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=269cc3a3e78eb7c8a4911244385c8f18")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                if data != nil {
                    do {
                        let response = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any> as Dictionary
                        
                        DispatchQueue.main.async { [self] in
                            if let rates = response["rates"] as? [String : Any] {
                                if let cadCurrency = rates["CAD"] as? Double {
                                    self.CADLabel.text = "CAD : \(String(cadCurrency))"
                                }
                                
                                if let usdCurrency = rates["USD"] as? Double {
                                    self.USDLabel.text = "USD : \(String(usdCurrency))"
                                }
                                
                                if let tryCurrency = rates["TRY"] as? Double {
                                    self.TRYLabel.text = "TRY : \(String(tryCurrency))"
                                }
                                
                                if let gbpCurrency = rates["GBP"] as? Double {
                                    self.GBPLabel.text = "GBP : \(String(gbpCurrency))"
                                }
                            }
                            
                            
                        }
                        

                    } catch {
                        print("error")
                    }
                   
                    
                    
                }
            }
        }
        task.resume()
    }
}

