//
//  NicknameViewController.swift
//  WebSockets_PDP
//
//  Created by Никита Лужбин on 17.12.2020.
//  Copyright © 2020 flatstack. All rights reserved.
//

import UIKit

class NicknameViewController: UIViewController {

    // MARK: - Nested Types

    private enum Segues {

        static let ShowChatViewController = "ShowChatViewController"
    }

    // MARK: - Instance Properties

    @IBOutlet private weak var nicknameTextField: UITextField!

    // MARK: -

    private var socketService = Services.defaultSocketService

    // MARK: - Instance Methods

    @IBAction private func goButtonTouchUpInside(_ sender: UIButton) {
        guard let nickname = self.nicknameTextField.text, !nickname.isEmpty else {
            return
        }

        self.performSegue(withIdentifier: Segues.ShowChatViewController, sender: nickname)
    }

    // MARK: - UIViewControler

    override func viewDidLoad() {
        super.viewDidLoad()

        self.socketService.establishConnection()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chatViewController = segue.destination as? ChatViewController, let nickname = sender as? String {
            chatViewController.nickname = nickname
        }
    }
}
