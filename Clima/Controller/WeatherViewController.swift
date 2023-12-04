//
//  ViewController.swift
//  Clima


import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    
   
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
  
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchTextField.delegate = self
        weatherManager.delegate = self
       
    }

   
    @IBAction func locationPressed(_ sender: UIButton) {
        
        locationManager.requestWhenInUseAuthorization()
    }
    
}

//MARK: -UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
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
        
        if let city = self.searchTextField.text {
            
            weatherManager.fetchWether(cityName: city)
            
        }
        
        
    }
    
}

//MARK: -WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather.temprature)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempratureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
   func didFailWithError(error: Error){
        print(error)
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            print("latitude is", lat)
            print("longitude is", long)
            weatherManager.fetchWeather(latitude: lat, langitude: long)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
}
