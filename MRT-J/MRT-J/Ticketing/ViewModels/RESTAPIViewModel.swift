//
//  RESTAPIViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation

class RESTAPIViewModel: ObservableObject {
    
    func getTicket(name: String, email: String, completion: @escaping ([String : Any]?) -> Void ) {
        
        guard let url = URL(string: "https://3691-103-154-141-89.ngrok-free.app/api/ticket/\(name)/\(email)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(jsonDict)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error decoding JSON data: \(error)")
                completion(nil)
            }
            
        }
        completion(nil)
        return
    }
}
