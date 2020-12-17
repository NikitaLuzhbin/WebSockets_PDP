//
//  ChatViewController.swift
//  WebSockets_PDP
//
//  Created by Никита Лужбин on 17.12.2020.
//  Copyright © 2020 flatstack. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - Instance Properties
    
    @IBOutlet private weak var tableView: UITableView!

    // MARK: -

    var nickname: String!
    var chatMessages: [ChatMessage] = []

    var socketService = Services.defaultSocketService

    // MARK: - Instance Methods

    private func configureTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    private func configureInitialState() {
        self.title = nickname
    }

    private func connectToChat() {
        self.socketService.connectToChat(with: self.nickname)
    }

    private func startObservingMessages() {
        self.socketService.observeMessages { [weak self] data in
            if let nickname = data["nickname"] as? String, let message = data["message"] as? String {
                self?.chatMessages.append(ChatMessage(nickname: nickname,
                                                      message: message))
                self?.tableView.reloadData()
            } else {
                print("Couldn't decode chat message")
            }
        }
    }

    private func configure(cell: ChatMessageCell, for indexPath: IndexPath) {
        let chatMessage = self.chatMessages[indexPath.row]

        cell.author = chatMessage.nickname
        cell.message = chatMessage.message
    }

    private func send(message: String) {
        self.socketService.send(message: message, username: self.nickname)
    }

    // MARK: -

    @IBAction func onAddMessageButtonTouchUpInside(_ sender: Any) {
        let alertController = UIAlertController(title: "Send Message", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Message..."
        }

        let sendAction = UIAlertAction(title: "Send", style: .default) { action in
            guard let messageTextField = alertController.textFields?.first, let message = messageTextField.text else {
                return
            }

            self.send(message: message)
        }

        alertController.addAction(sendAction)

        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        self.configureInitialState()

        self.connectToChat()
        self.startObservingMessages()
    }
}

// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {

    // MARK: - Instance Methods
}

// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {

    // MARK: - Instance Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ChatMessageCell.reuseIdentifier) as! ChatMessageCell

        self.configure(cell: cell, for: indexPath)

        return cell
    }
}
