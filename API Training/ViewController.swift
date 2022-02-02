//
//  ViewController.swift
//  API Training
//
//  Created by Oksana Poliakova on 02.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Post
    struct Post: Codable {
        let userID: Int
        let id: Int
        let title: String
        let body: String

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case id = "id"
            case title = "title"
            case body = "body"
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
                let json = try JSONDecoder().decode([Post].self, from: data)
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    @IBAction func postTapped(_ sender: UIButton) {
        
    }
}

