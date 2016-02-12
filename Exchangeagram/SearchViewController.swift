//
//  SearchViewController.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/10/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var picArray:[String] = []
    

    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        picArray = ["image1", "image2", "image3", "image4", "image5", "image6", "image6", "image1", "image2", "image3", "image4", "image5", "image6", "image6", "image1", "image2", "image3", "image4", "image5", "image6", "image6","image1", "image2", "image3", "image4", "image5", "image6", "image6","image1", "image2", "image3", "image4", "image5", "image6", "image6","image1", "image2", "image3", "image4", "image5", "image6", "image6","image1", "image2", "image3", "image4", "image5", "image6", "image6"]

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell

        cell.photoView.image = UIImage(named: picArray[indexPath.row])

        return cell

    }



}
