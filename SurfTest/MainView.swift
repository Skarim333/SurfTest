//
//  MainView.swift
//  SurfTest
//
//  Created by Карим Садыков on 13.02.2023.
//

import UIKit

final class MainView: UIView {
    
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constan.mainTitle
        label.font = .sfProDisplayBold(size: 24)
        label.textColor = Color.lightBlack
        return label
    }()
    
    let infoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constan.infoTitle
        label.font = .sfProDisplayMedium(size: 14)
        label.numberOfLines = 0
        label.textColor = Color.gray
        return label
    }()
    
    let infoTitleLabel2: UILabel = {
        let label = UILabel()
        label.text = Constan.infoTitle2
        label.font = .sfProDisplayMedium(size: 14)
        label.numberOfLines = 0
        label.textColor = Color.gray
        return label
    }()
    
    let carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = Color.white
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    let doubleCarouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.backgroundColor = Color.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(carouselCollectionView)
        addSubview(doubleCarouselCollectionView)
        addSubview(mainTitleLabel)
        addSubview(infoTitleLabel)
        addSubview(infoTitleLabel2)
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        mainTitleLabel.frame = CGRect(x: 20, y: 24, width: width-40, height: 32)
        infoTitleLabel.frame = CGRect(x: 20, y: mainTitleLabel.bottom+12, width: width-40, height: 60)
        carouselCollectionView.frame = CGRect(x: left, y: infoTitleLabel.bottom+12, width: width, height: 50)
        infoTitleLabel2.frame = CGRect(x: 20, y: carouselCollectionView.bottom+24, width: width-40, height: 40)
        doubleCarouselCollectionView.frame = CGRect(x: left, y: infoTitleLabel2.bottom+12, width: width, height: 100)
        layer.cornerRadius = 30
    }
    
}
extension Metrics {
    static let buttonCornerRadius: CGFloat = 30
    static let containerViewCornerRadius: CGFloat = 25
    static let titleLabelTop: CGFloat = 24
    static let titleLabelLeading: CGFloat = 20
    static let infoLabelTop: CGFloat = 12
    static let infoLabelLeadingTrailing: CGFloat = 20
    static let carouselsTop: CGFloat = 12
    static let carouselHeight: CGFloat = 50
    static let awardLabelTop: CGFloat = 24
    static let awardLabelLeadingTrailing: CGFloat = 20
    static let doubleCarouselHeight: CGFloat = 100
    static let wantToJoinUsLabelTop: CGFloat = 20
    static let sendRequestButtonTrailing: CGFloat = -20
    static let sendRequestButtonHeight: CGFloat = 60
    static let sendRequestButtonWidth: CGFloat = 219
    static let sendRequestButtonBottom: CGFloat = -58
}

