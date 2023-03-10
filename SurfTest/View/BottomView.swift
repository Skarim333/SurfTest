//
//  BottomView.swift
//  SurfTest
//
//  Created by Карим Садыков on 13.02.2023.
//

import UIKit

protocol BottomViewDelegate: AnyObject {
    func didTappedSendApplicationButton()
}

final class BottomView: UIView {
    
    weak var delegate: BottomViewDelegate?
    
    lazy var sendRequestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constant.sendButtonTitle, for: .normal)
        button.titleLabel?.font = .sfProDisplayMedium(size: 16)
        button.backgroundColor = Color.lightBlack
        button.setTitleColor(Color.white, for: .normal)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var sendDescription: UILabel = {
        let label = UILabel()
        label.text = Constant.sendLabelTitle
        label.font = .sfProDisplayMedium(size: 14)
        label.textColor = Color.gray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }
        
    private func setup() {
        addSubview(sendRequestButton)
        addSubview(sendDescription)
        sendDescription.translatesAutoresizingMaskIntoConstraints = false
        sendRequestButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sendRequestButton.topAnchor.constraint(equalTo: topAnchor),
            sendRequestButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sendRequestButton.heightAnchor.constraint(equalToConstant: 60),
            sendRequestButton.widthAnchor.constraint(equalToConstant: 219),
            sendDescription.centerYAnchor.constraint(equalTo: sendRequestButton.centerYAnchor),
            sendDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sendDescription.trailingAnchor.constraint(lessThanOrEqualTo: sendRequestButton.leadingAnchor, constant: -24)
        ])
        sendRequestButton.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func onButtonTapped(_ sender: UIButton) {
        delegate?.didTappedSendApplicationButton()
    }
}


