//
//  MainViewController.swift
//  SurfTest
//
//  Created by Карим Садыков on 13.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private let bottomView = BottomView()
    private var isSelect = false
    private var previousIndex: IndexPath?
    private let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.contentMode = .scaleAspectFill
        return view
    }()
    let items = Constan.items
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        view.addSubview(bottomView)
//        view.addSubview(mainView)
        mainView.carouselCollectionView.delegate = self
        mainView.carouselCollectionView.dataSource = self
        mainView.doubleCarouselCollectionView.delegate = self
        mainView.doubleCarouselCollectionView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 500/2, section: 0)
        mainView.carouselCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        backgroundImageView.frame = view.bounds
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50)
        mainView.frame = CGRect(x: 0, y: 600, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.5)
//        mainView.frame = CGRect(x: 0, y: 50, width: view.width, height: view.height-120)
        bottomView.frame = CGRect(x: 0, y: view.height-120, width: view.width, height: 120)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.height
        }
    }
    
}


extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == mainView.carouselCollectionView ? 500 : items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriesCollectionViewCell.identifier,
            for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
        let elementIndex = indexPath.item % items.count
        cell.categoriesLabel.text = items[elementIndex]
        return cell
    }

}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Deselect all previous items, if any
        if collectionView == mainView.carouselCollectionView {
            if let previousIndex = previousIndex {
                for item in 0...500 {
                    if (item % items.count) == (
                        previousIndex.item % items.count) {
                        let indexPath = IndexPath(item: item, section: 0)
                        collectionView.deselectItem(at: indexPath, animated: true)
                    }
                }
            }
            
            // Select all new elements
            for item in 0...500 {
                if (item % items.count) == (indexPath.item % items.count) {
                    let indexPath = IndexPath(item: item, section: 0)
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    isSelect = true
                }
            }
            previousIndex = indexPath
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
        
        if collectionView == mainView.doubleCarouselCollectionView {
            isSelect = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Deselect item when scroll item is select
        if collectionView == mainView.carouselCollectionView {
            if let previousIndex = previousIndex {
                for item in 0...500 {
                    if (item % items.count) == (previousIndex.item % items.count) {
                        let indexPath = IndexPath(item: item, section: 0)
                        collectionView.deselectItem(at: indexPath, animated: true)
                        isSelect = false
                    }
                }
            }
        }
        
        if collectionView == mainView.doubleCarouselCollectionView {
            isSelect = false
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
}


