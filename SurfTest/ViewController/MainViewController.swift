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
    var items = Constant.items
    private var currentContainerHeight = Constants.currentContainerHeight
    private let defaultHeight = Constants.defaultHeight
    private let maximumContainerHeight = Constants.maximumContainerHeight


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainView)
        view.addSubview(bottomView)
        mainView.carouselCollectionView.delegate = self
        mainView.carouselCollectionView.dataSource = self
        mainView.doubleCarouselCollectionView.delegate = self
        mainView.doubleCarouselCollectionView.dataSource = self
        bottomView.delegate = self
        setupPanGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainView.frame = CGRect(x: 0, y: self.view.height, width: self.view.width, height: 0)
        self.mainView.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentContainer()
        let indexPath = IndexPath(item: 500/2, section: 0)
        mainView.carouselCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        backgroundImageView.frame = view.bounds

        bottomView.frame = CGRect(x: 0, y: view.height-120, width: view.width, height: 120)
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight > maximumContainerHeight {
                animateContainerHeight(maximumContainerHeight)
            }
        case .ended:
            if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                UIView.animate(withDuration: 0.3, delay: 0.1) {
                    self.mainView.frame = CGRect(x: 0, y: 50, width: self.view.width, height: self.view.height)
                    self.mainView.layoutIfNeeded()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.mainView.infoTitleLabel2.isHidden = false
                    self.mainView.doubleCarouselCollectionView.isHidden = false
                }
            }
        default:
            break
        }
    }
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.mainView.frame = CGRect(x: 0, y: self.view.height, width: self.view.width, height: -height)
            self.mainView.layoutIfNeeded()
        }
        currentContainerHeight = height
        
        self.mainView.infoTitleLabel2.isHidden = true
        self.mainView.doubleCarouselCollectionView.isHidden = true
    }
    private func animatePresentContainer() {
        UIView.animate(withDuration: 0.2) {
            self.mainView.frame = CGRect(x: 0, y: self.view.height, width: self.view.width, height: -330)
            self.mainView.layoutIfNeeded()
        }
        mainView.isHidden = false
        mainView.infoTitleLabel2.isHidden = true
        mainView.doubleCarouselCollectionView.isHidden = true
    }
}

extension MainViewController: BottomViewDelegate {
    func didTappedSendApplicationButton() {
        let alertController = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Закрыть", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
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
        
        if collectionView == mainView.carouselCollectionView {
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
            collectionView.performBatchUpdates {
                let selectCell = items[indexPath.item % items.count]
                items.remove(at: indexPath.item)
                items.insert(selectCell, at: 0)
                mainView.doubleCarouselCollectionView.moveItem(
                    at: indexPath,
                    to: [0, 0]
                    )
            }
        }
    }
    
}

enum Constants {
    static let currentContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.5
    static let defaultHeight: CGFloat = 330
    static let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 50
}


