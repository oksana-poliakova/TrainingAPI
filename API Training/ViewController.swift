//
//  ViewController.swift
//  API Training
//
//  Created by Oksana Poliakova on 02.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - jsonplaceholder.typicode.com
    // MARK: - GetInfo
    
    struct GetInfo: Codable {
        let userID: Int?
        let id: Int?
        let title: String?
        let body: String?

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case id = "id"
            case title = "title"
            case body = "body"
        }
    }
    
    // MARK: - Post
    
    struct Post: Codable {
        let username: String
        let age: String
        
        enum CodingKeys: String, CodingKey {
            case username = "username"
            case age = "age"
        }
    }
    
    // MARK: - Posts OpenWeatherMap
    
    struct WeatherPosts: Codable {
        let coord: Coord
        let wind: Wind
        let main: Main

        enum CodingKeys: String, CodingKey {
            case coord = "coord"
            case wind = "wind"
            case main = "main"
        }
    }

    // MARK: - Coord
    struct Coord: Codable {
        let lon: Double
        let lat: Double

        enum CodingKeys: String, CodingKey {
            case lon = "lon"
            case lat = "lat"
        }
    }
    
    // MARK: - Main
    struct Main: Codable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double

        enum CodingKeys: String, CodingKey {
            case temp = "temp"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }

    // MARK: - Wind
    struct Wind: Codable {
        let speed: Double

        enum CodingKeys: String, CodingKey {
            case speed = "speed"
        }
    }

    
    
    // MARK: - Get request
    
    @IBAction func getTapped(_ sender: UIButton) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            if let error = error {
                print(error)
            }
            do {
                guard let data = data else { return }
                let json = try JSONDecoder().decode(GetInfo.self, from: data)
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // MARK: - Post request
    
    @IBAction func postTapped(_ sender: UIButton) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        let parameters: [String: Any] = [
            "username": "Masha",
            "age": "7"
        ]
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            
            if let error = error {
                print(error)
            }
            
            do {
                guard let data = data else { return }
                let json = try JSONDecoder().decode(Post.self, from: data)
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // MARK: - OpenWeatherMap
    
    @IBAction func getWeatherTapped(_ sender: UIButton) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=48.292079&lon=25.935837&appid=81d95022ccf3a89690dc0bd6f509365a") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            if let error = error {
                    print(error)
            }
            
            do {
                guard let data = data else { return }
                let json = try JSONDecoder().decode(WeatherPosts.self, from: data)
                print(json)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}

