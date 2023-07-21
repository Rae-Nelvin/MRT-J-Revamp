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
    case notFound
    case unknown
    case other(Error)
}

class RESTAPIViewModel: ObservableObject {
    
    let ngrokURL = "https://57fe-158-140-189-122.ngrok-free.app"
    
    func getNotification(name: String, email: String, completion: @escaping (Result<Notification?, Error>) -> Void) {
        guard let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let urlString = "\(ngrokURL)/api/notification/\(encodedName)/\(encodedEmail)"
        
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
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let decoder = JSONDecoder()
                        let notificationResponse = try decoder.decode(NotificationResponseModel.self, from: data)
                        let notification = notificationResponse.data
                        completion(.success(notification))
                    } catch {
                        completion(.failure(APIError.other(error)))
                    }
                default:
                    completion(.failure(APIError.other(NSError(domain: "", code: httpResponse.statusCode, userInfo: nil))))
                }
            } else {
                completion(.failure(APIError.unknown))
            }
        }
        task.resume()
    }
    
    func deleteNotification(notification: Notification, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let notificationID = notification.id
        let urlString =  "\(ngrokURL)/api/notification/delete/\(String(describing: notificationID))"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(true))
                case 404:
                    completion(.failure(APIError.noData))
                default:
                    completion(.failure(APIError.other(NSError(domain: "", code: httpResponse.statusCode, userInfo: nil))))
                }
            } else {
                completion(.failure(APIError.unknown))
            }
        }
        task.resume()
    }
    
    func getTicket(name: String, email: String, completion: @escaping (Result<Ticket?, Error>) -> Void) {
        guard let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        let urlString = "\(ngrokURL)/api/ticket/\(encodedName)/\(encodedEmail)"

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
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let decoder = JSONDecoder()
                        let ticketResponse = try decoder.decode(TicketResponseModel.self, from: data)
                        let ticket = ticketResponse.data
                        completion(.success(ticket))
                    } catch {
                        completion(.failure(APIError.other(error)))
                    }
                case 404:
                    completion(.success(nil))
                default:
                    completion(.failure(APIError.other(NSError(domain: "", code: httpResponse.statusCode, userInfo: nil))))
                }
            } else {
                completion(.failure(APIError.unknown))
            }
        }
        task.resume()
    }
    
}
