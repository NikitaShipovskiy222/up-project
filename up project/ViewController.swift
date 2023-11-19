//
//  ViewController.swift
//  up project
//
//  Created by Nikita Shipovskiy on 19/11/2023.
//

import UIKit




class ViewController: UIViewController {

    var count = 0
    var historyText = "История изменений:\n"
    
    // UI element
    var label: UILabel!
    var historyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        //Label to display counter
        label = UILabel()
        label.text = "\(count)"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 50)
        view.addSubview(label)

        // button
        createButton(title: "+", color: .red, action: #selector(increment), frame: CGRect(x: 50, y: 200, width: 50, height: 50))
        createButton(title: "-", color: .blue, action: #selector(decrement), frame: CGRect(x: 150, y: 200, width: 50, height: 50))
        createButton(title: "Сброс", color: .gray, action: #selector(reset), frame: CGRect(x: 250, y: 200, width: 100, height: 50))

        // text
        historyTextView = UITextView()
        historyTextView.text = historyText
        historyTextView.isEditable = false
        historyTextView.frame = CGRect(x: 20, y: 300, width: view.frame.width - 40, height: 150)
        view.addSubview(historyTextView)
    }

    func createButton(title: String, color: UIColor, action: Selector, frame: CGRect) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = color
        button.addTarget(self, action: action, for: .touchUpInside)
        button.frame = frame
        view.addSubview(button)
    }

    @objc func increment() {
        count += 1
        updateLabelAndHistory(newValue: count, action: "увеличено на 1")
    }

    @objc func decrement() {
        if count > 0 {
            count -= 1
            updateLabelAndHistory(newValue: count, action: "уменьшено на 1")
        } else {
            updateHistory(action: "попытка уменьшить значение счётчика ниже 0")
        }
    }

    @objc func reset() {
        count = 0
        updateLabelAndHistory(newValue: count, action: "сброшено")
    }

    func updateLabelAndHistory(newValue: Int, action: String) {
        label.text = "\(newValue)"
        updateHistory(action: action)
    }

    func updateHistory(action: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        historyText += "[\(dateString)]: \(action)\n"
        historyTextView.text = historyText

        // scroll down
        let range = NSMakeRange(historyText.count - 1, 0)
        historyTextView.scrollRangeToVisible(range)
    }
}






