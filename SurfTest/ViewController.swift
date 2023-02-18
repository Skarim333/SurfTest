//
//  ViewController.swift
//  SurfTest
//
//  Created by Карим Садыков on 13.02.2023.
//

import UIKit

class ViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    let imageView = UIImageView()
    let viewA = UIView()
    let submitApplicationLabel = UILabel()
    let joinUsLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: "backgroundImage")
        imageView.contentMode = .scaleAspectFill
        viewA.backgroundColor = .blue

        submitApplicationLabel.text = "Submit an application"
        submitApplicationLabel.textAlignment = .center
        submitApplicationLabel.font = UIFont.systemFont(ofSize: 17)

        joinUsLabel.text = "Do you want to join us?"
        joinUsLabel.textAlignment = .center
        joinUsLabel.font = UIFont.systemFont(ofSize: 17)
        view.backgroundColor = .white
        imageView.backgroundColor = .yellow
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.addSubview(imageView)
        view.addSubview(viewA)
        view.addSubview(scrollView)
        view.addSubview(submitApplicationLabel)
        view.addSubview(joinUsLabel)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewA.frame = view.bounds
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50)
        imageView.frame = CGRect(x: 0, y: 500, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.5)
//        scrollView.contentSize = imageView.frame.size

        submitApplicationLabel.frame = CGRect(x: 0, y: view.frame.height - 25, width: view.frame.width, height: 25)
        joinUsLabel.frame = CGRect(x: 0, y: view.frame.height - 50, width: view.frame.width, height: 25)
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
//        if bottomEdge >= scrollView.contentSize.height {
//            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.frame.size.height), animated: false)
//        }
        let ds = scrollView.contentOffset.y + scrollView.frame.origin.y
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.frame.size.height), animated: false)
        } else if ds <= scrollView.frame.origin.y {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.frame.origin.y), animated: false)
        }
        print("scrollView.contentOffset.y\(scrollView.frame.origin.y)")
        
    }
}
