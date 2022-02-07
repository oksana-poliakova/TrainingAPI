//
//  ViewController.swift
//  API Training
//
//  Created by Oksana Poliakova on 02.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Post
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
    
    struct Post: Codable {
        let username: String?
        let age: String?
        
        enum CodingKeys: String, CodingKey {
            case username = "username"
            case age = "age"
        }
    }
    
    

    
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
                let json = try JSONDecoder().decode([GetInfo].self, from: data)
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
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
}

