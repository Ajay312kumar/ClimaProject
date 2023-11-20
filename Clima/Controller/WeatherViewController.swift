//
//  ViewController.swift
//  Clima


import UIKit

class WeatherViewController: UIViewController,UITextFieldDelegate,WeatherManagerDelegate {
   
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
  
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchTextField.delegate = self
        
    }

    @IBAction func searchPressedAction(_ sender: UIButton) {
        
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
   
    
    func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != " "{
            return true
        }else{
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            
            weatherManager.fetchWether(cityName: city)
            
        }
        
        
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temprature)
    }
}

