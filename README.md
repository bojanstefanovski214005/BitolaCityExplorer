# Bitola City Explorer — iOS SwiftUI project

Овој проект е изработен според проектната задача за **Bitola City Explorer**.

## Барања што се покриени

- **Мапи и локациски сервиси:** `MapKit`, `CoreLocation`, `MapScreen`, `LocationService`
- **Mock нотификации:** локални нотификации преку `UserNotifications`; тест нотификација се појавува по ~5 секунди
- **Камера + сензор:** `UIImagePickerController` за камера и `LocalAuthentication` / FaceID за Favorites
- **Надворешен API:** Open-Meteo API за моментална температура, feels-like температура и weather code
- **Custom View + анимација:** `AnimatedPlaceCard` со custom изглед, shadow, rounded corners, scale и opacity animation
- **3rd party библиотека:** Kingfisher 8.x преку Swift Package Manager за download/cache на remote слики
- **Повеќе view-а:** Splash, Home, Map, Details, Favorites, Camera, Settings
- **SwiftData + UserDefaults:** SwiftData за омилени места; `@AppStorage`/UserDefaults за темна тема и нотификации

## Како да го пуштиш

1. Отвори `BitolaCityExplorer.xcodeproj` во Xcode.
2. Почекај Xcode автоматски да го преземе Kingfisher package-от.
3. Одбери iOS 17+ simulator или физички iPhone.
4. Build & Run.
5. Дозволи Location и Notifications кога ќе бидат побарани.

## FaceID во Simulator

За демонстрација во iOS Simulator:

1. `Features` → `Face ID` → `Enrolled`
2. Отвори го табот **Омилени**.
3. Притисни **Отклучи со FaceID**.
4. `Features` → `Face ID` → `Matching Face`.

На физички iPhone, FaceID работи преку системскиот FaceID дијалог.

## Камера

`UIImagePickerController` со `.camera` не работи на сите Simulator конфигурации. За сигурна демонстрација користи физички iPhone. Апликацијата прикажува порака ако камерата не е достапна.

## Надворешен API

Проектот користи **Open-Meteo**, бидејќи не бара API key и може веднаш да се демонстрира. Архитектурата е во `WeatherAPIService.swift`, па сервисот лесно може да се замени со OpenWeather ако професорот бара токму OpenWeather.

## Забелешка за слики

Демо-сликите се вчитуваат од `picsum.photos` за сигурно да се демонстрира Kingfisher download/cache. Можеш подоцна да ги замениш `imageURL` вредностите во `SamplePlaces.swift` со вистински фотографии од локациите.
