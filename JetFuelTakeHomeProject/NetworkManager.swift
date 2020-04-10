//
//  NetworkManager.swift
//  JetFuelTakeHomeProject
//
//  Created by Tayler Moosa on 4/8/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager ()
    private init() {}
    
    let cache = NSCache<NSString,UIImage>()
    
    
    func getPlugs(completed: @escaping (Result<Welcome,Error>) -> Void) {
        guard let baseURL = URL(string: "https://www.plugco.in/public/take_home_sample_feed") else { return }
        
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let error = error {
                completed(.failure(error))
            }
            guard let response  = response as? HTTPURLResponse else { return }
            guard let data      = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(Welcome.self, from: data)
                completed(.success(result))
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getImage(url: String, completed: @escaping (Result<UIImage,Error>) -> Void) {
        let cacheKey = NSString(string: url)
        if let image = cache.object(forKey: cacheKey) {
            completed(.success(image))
        }
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completed(.success(image))
            self.cache.setObject(image, forKey: cacheKey)
            
        }
        task.resume()
        
    }
    
    func downloadData(url: String) {
        let documentsUrl : URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)!
        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.jpg")
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.downloadTask(with: url) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
        }
        task.resume()
        
    }
}
