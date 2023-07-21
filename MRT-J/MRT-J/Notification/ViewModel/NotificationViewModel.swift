//
//  NotificationViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 20/07/23.
//

import Foundation

class NotificationViewModel: ObservableObject {
    
    let ravm: RESTAPIViewModel = RESTAPIViewModel()
    private var tvm: TicketingViewModel?
    private var notifications: [Notification]
    
    init(tvm: TicketingViewModel) {
        self.tvm = tvm
        self.notifications = []
        self.deleteNotification()
    }
    
    func getNotification() {
        var i = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            self?.ravm.getNotification(name: "Leonardo Wijaya", email: "leonardo.wijaya003@binus.ac.id") { result in
                DispatchQueue.main.async {
                    self?.objectWillChange.send()
                }
                switch result {
                case .success(let notification):
                    if notification?.status == "success" {
                        DispatchQueue.main.async {
                            self?.tvm?.statusTicketing = .success
                            timer.invalidate()
                        }
                    } else if notification?.status == "error" {
                        self?.tvm?.statusTicketing = .error
                        timer.invalidate()
                    }
                    guard let notification = notification else { return }
                    self?.notifications.append(notification)
                    return
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                }
            }
            i += 1
            if i > 9 {
                timer.invalidate()
            }
        })
        self.tvm?.checkTicket()
    }
    
    private func deleteNotification() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            guard let notification = self.notifications.first else { return }
            self.ravm.deleteNotification(notification: notification) { result in
                switch result {
                case .success(let result):
                    print(result)
                    return
                case .failure(let error):
                    print(error)
                    return
                }
            }
        }
    }
    
}
