//
//  ViewController.swift
//  NFC-Project
//
//  Created by Julian Harper on 5/13/19.
//  Copyright © 2019 Julian Harper. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController {
    
    var session: NFCNDEFReaderSession?

    @IBOutlet weak var tagText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readNFC()
    }
}

extension ViewController: NFCNDEFReaderSessionDelegate {
    
    func readNFC () {
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        session?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        var allMessages: String = ""
        
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .ascii) {
                    print(string)
                    allMessages += string
                }
            }
        }
        tagText.text = allMessages
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)   // Create error enum later
    }
}

