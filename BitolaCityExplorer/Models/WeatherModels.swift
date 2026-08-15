import Foundation

struct WeatherInfo: Sendable {
    let temperature: Double
    let apparentTemperature: Double
    let weatherCode: Int

    var description: String {
        switch weatherCode {
        case 0: return "Ведро"
        case 1...3: return "Променливо облачно"
        case 45, 48: return "Магла"
        case 51...57: return "Росење"
        case 61...67: return "Дожд"
        case 71...77: return "Снег"
        case 80...82: return "Пороен дожд"
        case 85, 86: return "Снежни врнежи"
        case 95: return "Грмежи"
        case 96, 99: return "Грмежи со град"
        default: return "Непознати услови"
        }
    }

    var systemImage: String {
        switch weatherCode {
        case 0: return "sun.max.fill"
        case 1...3: return "cloud.sun.fill"
        case 45, 48: return "cloud.fog.fill"
        case 51...57, 61...67, 80...82: return "cloud.rain.fill"
        case 71...77, 85, 86: return "cloud.snow.fill"
        case 95, 96, 99: return "cloud.bolt.rain.fill"
        default: return "cloud.fill"
        }
    }
}

struct OpenMeteoResponse: Decodable {
    let current: Current

    struct Current: Decodable {
        let temperature2m: Double
        let apparentTemperature: Double
        let weatherCode: Int

        enum CodingKeys: String, CodingKey {
            case temperature2m = "temperature_2m"
            case apparentTemperature = "apparent_temperature"
            case weatherCode = "weather_code"
        }
    }
}
