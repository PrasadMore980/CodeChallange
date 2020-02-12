//
//  ServiceManager.swift
//  TelstraCodeExercise
//
//  Created by Prasad More on 12/02/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

protocol ServiceManagerDelegate {
    
}


class ServiceManager {
    
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: getCountryData web service call
    func getCountryInfoData(url: String, onCompletion: @escaping (Result<CountryInfo>) -> Void) {
        guard let url = URL(string: url) else { return }
        let dataTask = session.downloadTask(with: url) { localURL, urlResponse, error in
            
            if let localURL = localURL {
                let someData = try! Data.init(contentsOf: localURL, options: .mappedIfSafe)
                do {
                    // To make sure this JSON is in the format we expect
                    let str = String(decoding: someData, as: UTF8.self)
                    print(str)
                    let data: Data? = str.data(using: .utf8)
                    guard let decodedResponse = try? JSONDecoder().decode(CountryInfo.self, from: data!) else {
                        onCompletion(Result.failure("Please check your network conectivity"))
                        return
                    }
                    let deFile = FileManager.default
                    if deFile.isDeletableFile(atPath: localURL.absoluteString){
                        try deFile.removeItem(at: localURL)
                    }
                    onCompletion(Result.success(decodedResponse))
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        }
        dataTask.resume()
    }
}

