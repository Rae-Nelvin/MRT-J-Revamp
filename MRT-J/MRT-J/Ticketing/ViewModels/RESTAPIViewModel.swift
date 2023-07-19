//
//  RESTAPIViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case decodingFailed
    case other(Error)
}

class RESTAPIViewModel: ObservableObject {
    
    func getTicket(name: String, email: String, completion: @escaping (Result<Ticket?, Error>) -> Void) {
        guard let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        let urlString = "https://3691-103-154-141-89.ngrok-free.app/api/ticket/\(encodedName)/\(encodedEmail)"

        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let ticketResponse = try decoder.decode(TicketResponse.self, from: data)
                let ticket = ticketResponse.data
                completion(.success(ticket))
            } catch {
                completion(.success(nil))
            }
        }
        task.resume()
    }
    
}
