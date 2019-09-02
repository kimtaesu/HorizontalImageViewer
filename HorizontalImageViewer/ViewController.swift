//
//  ViewController.swift
//  HorizontalImageViewer
//
//  Created by tskim on 03/09/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = SnappingCollectionViewLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()

    @IBOutlet weak var collectionView: UICollectionView!
    let panGR = UIPanGestureRecognizer()

    var images = ImageLoader.sampleImageURLs
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.register(ScrollingImageCell.self, forCellWithReuseIdentifier: ScrollingImageCell.swiftIdentifier)
        self.collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.panGR.delegate = self
        self.collectionView.addGestureRecognizer(panGR)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrollingImageCell.swiftIdentifier, for: indexPath) as? ScrollingImageCell else {
            return UICollectionViewCell()
        }
        
        cell.imageSize = CGSize(width: 640, height: 480)
        cell.imageView.kf.setImage(with: self.images[indexPath.item])
        return cell
    }
    
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? ScrollingImageCell)?.imageView.kf.cancelDownloadTask()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

extension ViewController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let cell = collectionView.visibleCells[0] as? ScrollingImageCell,
            cell.scrollView.zoomScale == 1 {
            let v = panGR.velocity(in: nil)
            return v.y > abs(v.x)
        }
        return false
    }
}
