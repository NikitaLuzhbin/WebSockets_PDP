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
    var chatMessages: [ChatMessage] = [ChatMessage(nickname: "Nikita", message: "Hello World"),
                                       ChatMessage(nickname: "Ivan", message: "Hi, Nikita")]

    // MARK: - Instance Methods

    private func configureTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    private func configureInitialState() {
        self.title = nickname
    }

    private func configure(cell: ChatMessageCell, for indexPath: IndexPath) {
        let chatMessage = self.chatMessages[indexPath.row]

        cell.author = chatMessage.nickname
        cell.message = chatMessage.message
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        self.configureInitialState()
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
