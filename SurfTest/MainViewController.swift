//
//  MainViewController.swift
//  SurfTest
//
//  Created by Карим Садыков on 13.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainIView = MainView()
    private let bottomView = BottomView()
    private let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.contentMode = .scaleAspectFill
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let items = Constan.items
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(mainIView)
        view.addSubview(bottomView)
        mainIView.carouselCollectionView.delegate = self
        mainIView.carouselCollectionView.dataSource = self
        mainIView.doubleCarouselCollectionView.delegate = self
        mainIView.doubleCarouselCollectionView.dataSource = self
        let indexPath = IndexPath(item: 500/2, section: 0)
        mainIView.carouselCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        backgroundImageView.frame = view.bounds
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50)
        mainIView.frame = CGRect(x: 0, y: 600, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.5)
//        mainIView.frame = CGRect(x: 0, y: 50, width: view.width, height: view.height-120)
        bottomView.frame = CGRect(x: 0, y: view.height-120, width: view.width, height: 120)
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let ds = scrollView.contentOffset.y + scrollView.frame.origin.y
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.frame.size.height), animated: false)
        } else if ds <= scrollView.frame.origin.y {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.frame.origin.y), animated: false)
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == mainIView.carouselCollectionView ? 500 : items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriesCollectionViewCell.identifier,
            for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
        let elementIndex = indexPath.item % items.count
        cell.categoriesLabel.text = items[elementIndex]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        let numberOfCellsPerRow = 2
        let cellWidth = (screenWidth - (CGFloat(numberOfCellsPerRow - 1) * 12)) / CGFloat(numberOfCellsPerRow)
        
        if cellWidth <= 0 {
            return .zero
        } else {
            return CGSize(width: cellWidth, height: 44)
        }
    }
}


