struct WeatherData: Decodable {
    
    let name: String
    let cod: Int
    let main: Main
    let coord: Coord
    let weather: [Weather]
}

struct Main: Decodable {
    
    let temp: Double
    
}

struct Coord: Decodable {
    let lat: Double
    let lon: Double
}


struct Weather: Decodable {
    
    let id: Int
//    let main: String
    let description: String
    //let icon: Int
}

