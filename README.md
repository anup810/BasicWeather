# BasicWeather

A simple weather app for iOS that provides current weather conditions, hourly forecasts, and a 5-day weather outlook. Built using **Swift** and **UIKit**, it fetches real-time weather data using the **OpenWeather API**.

## 📌 Features

- Search for a city and retrieve weather details
- View current temperature, weather conditions, and humidity
- Hourly weather forecast
- 5-day weather forecast with min/max temperature
- Background color adapts to weather conditions
- User location persistence using `UserDefaults`

## 📂 Folder Structure

```
BasicWeather
│── App
│   ├── Api.swift
│   ├── AppDelegate.swift
│   ├── Extensions.swift
│   ├── LaunchScreen.storyboard
│   ├── LocationManager.swift
│   ├── SceneDelegate.swift
│
│── HomeVC
│   ├── BottomRow
│   │   ├── HomeWeeklyForecastRow.swift
│   │   ├── WeeklyForecastDetailRow.swift
│   ├── MiddleRow
│   │   ├── DailyForecastCell.swift
│   │   ├── HomeCarouselRow.swift
│   ├── TopRow
│   │   ├── HomeTopRow.swift
│   ├── HomeVC.swift
│   ├── Main.storyboard
│
│── Models
│   ├── CurrentWeather.swift
│   ├── DailyForecast.swift
│   ├── SearchLocation.swift
│   ├── WeatherType.swift
│   ├── WeeklyForecast.swift
│
│── SampleJSONs
│   ├── CurrentWeather.json
│   ├── SearchLocation.json
│   ├── WeeklyForecast.json
│
│── Search
│   ├── LocationRow.swift
│   ├── SearchResultVC.swift
│   ├── SearchVC.swift
│
│── Assets.xcassets
│── Info.plist
```

## 🛠️ Tech Stack

- **Swift 5**
- **UIKit**
- **Auto Layout & Storyboard**
- **URLSession (Networking)**
- **OpenWeather API**
- **UserDefaults**

## 🔧 Setup & Installation

1. Clone the repository:
```bash
git clone https://github.com/anup810/BasicWeather.git
cd BasicWeather
```

2. Open `BasicWeather.xcodeproj` in **Xcode**

3. Install dependencies (if any) using:
```bash
pod install  # If using CocoaPods
```

4. Get an API Key from OpenWeather

5. Add your API key to **Info.plist**:
```xml
<key>Api_Key</key>
<string>YOUR_API_KEY_HERE</string>
```

6. Build and run the project on a simulator or device

