//
//  ViewController.swift
//  uikit_task_09
//
//  Created by Andrei on 27.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: view.bounds.width * 0.7, height: view.bounds.height * 0.6)
        layout.sectionInsetReference = .fromLayoutMargins

        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")

        return collectionView
    }()

    private lazy var randomColors: [UIColor] = {
        return (0...10).map { _ in UIColor.random }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground

        view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let itemWidth = collectionLayout.itemSize.width + collectionLayout.minimumInteritemSpacing
        let itemIndex = round(targetContentOffset.pointee.x / itemWidth)
        let offsetX = itemIndex * itemWidth - scrollView.layoutMargins.left

        targetContentOffset.pointee.x = offsetX
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "UICollectionViewCell",
            for: indexPath
        )
        cell.backgroundColor = randomColors[indexPath.item]
        cell.layer.cornerRadius = 15

        return cell
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: CGFloat(drand48()),
            green: 0.8,
            blue: CGFloat(drand48()),
            alpha: 1.0
        )
    }
}

