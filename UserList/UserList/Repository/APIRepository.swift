//
//  apiRepository.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 30/8/2023.
//

import UIKit

protocol APIRepositoryType {
    func fetchUsersApi(completion: @escaping ([Item]) -> Void)
    func fetchProfileApi(profileURL: String, completion: @escaping (Item) -> Void)
    func fetchFollowersApi(followerURL: String, completion: @escaping ([Item]) -> Void)
    func getImageData(stringURL: String, completion: @escaping (Data) -> ())
}

final class APIRepository: APIRepositoryType {
    
    static let shared = APIRepository()
    
    private init() {}
    
    func fetchUsersApi(completion: @escaping ([Item]) -> Void) {
        if let url = URL(string: Endpoint.api.rawValue) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let postData = data {
                        let decodedData = try JSONDecoder().decode(Response.self, from: postData)
                        DispatchQueue.main.async {
                            completion(decodedData.items)
                        }
                    } else {
                        print("No data")
                    }
                } catch {
                    print("Error \(error)")
                }
            }.resume()
        }
    }
    
    func fetchProfileApi(profileURL: String, completion: @escaping (Item) -> Void) {
        if let url = URL(string: profileURL){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let postData = data {
                        let decodedData = try JSONDecoder().decode(Item.self, from: postData)
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    } else {
                        print("No data")
                    }
                } catch {
                    print("Error \(error)")
                }
            }.resume()
        }
    }
    
    func fetchFollowersApi(followerURL: String, completion: @escaping ([Item]) -> Void) {
        if let url = URL(string: followerURL){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let postData = data {
                        let decodedData = try JSONDecoder().decode([Item].self, from: postData)
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    } else {
                        print("No data")
                    }
                } catch {
                    print("Error \(error)")
                }
            }.resume()
        }
    }
    
    func getImageData(stringURL: String, completion: @escaping (Data) -> ()) {
        if let url = URL(string: stringURL){
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    completion(data)
                }
            }.resume()
        }
    }
}
