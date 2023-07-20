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
    
    init(tvm: TicketingViewModel) {
        self.tvm = tvm
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
                        }
                    } else if notification?.status == "error" {
                        self?.tvm?.statusTicketing = .error
                    }
                    return
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                }
            }
            i += 1
            if i == 5 {
                timer.invalidate()
            }
        })
        if self.tvm?.statusTicketing ==  .success {
            self.tvm?.checkTicket()
        }
    }
    
}
