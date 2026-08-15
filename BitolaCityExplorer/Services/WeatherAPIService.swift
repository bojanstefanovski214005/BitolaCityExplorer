import Foundation

struct WeatherAPIService {
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherInfo {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.open-meteo.com"
        components.path = "/v1/forecast"
        components.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            URLQueryItem(name: "current", value: "temperature_2m,apparent_temperature,weather_code"),
            URLQueryItem(name: "timezone", value: "auto")
        ]

        guard let url = components.url else {
            throw WeatherError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw WeatherError.badResponse
        }

        let decoded = try JSONDecoder().decode(OpenMeteoResponse.self, from: data)
        return WeatherInfo(
            temperature: decoded.current.temperature2m,
            apparentTemperature: decoded.current.apparentTemperature,
            weatherCode: decoded.current.weatherCode
        )
    }

    enum WeatherError: LocalizedError {
        case invalidURL
        case badResponse

        var errorDescription: String? {
            switch self {
            case .invalidURL: return "Не може да се креира URL за временската прогноза."
            case .badResponse: return "Сервисот за временска прогноза врати неочекуван одговор."
            }
        }
    }
}
