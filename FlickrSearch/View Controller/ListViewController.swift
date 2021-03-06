//
//  ViewController.swift
//  FlickrSearch
//
//  Created by pankaj on 7/15/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet var viewModel: ListViewModel!
    @IBOutlet var collectionView : UICollectionView?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.searchImageWithText(searchText: "kittens",
                                      completionBlock: { (photos) in
             self.reloadCollectionView()
            
        }) { (error) in
            Utils.displayAlertView(titleText: "Error",
                                   message: error.localizedDescription,
                                   viewController: self)
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.activityIndicator.stopAnimating()
        }

    }
}

extension ListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)),
                                               object: searchBar)
        perform(#selector(self.reload(_:)),
                with: searchBar, afterDelay: 0.75)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        if (searchBar.text?.count)! > 2 {
            self.activityIndicator.startAnimating()
            viewModel.searchImageWithText(searchText: searchBar.text!,
                                          completionBlock: { (photos) in
                self.reloadCollectionView()
            }) { (error) in
                Utils.displayAlertView(titleText: "Error",
                                       message: error.localizedDescription,
                                       viewController: self)
            }
        print(query)
    }
    }}

extension ListViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let totalNumberOfcell: Int?
        if let totalImage = viewModel.searchResult {
            if totalImage.count % Constants.numberOfGris == 0 {
                totalNumberOfcell = totalImage.count / Constants.numberOfGris
            }
            else{
                totalNumberOfcell = (totalImage.count / Constants.numberOfGris) + 1
            }
        }
        else {
            totalNumberOfcell = 0
        }
        
        return totalNumberOfcell!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifierForCollectionView,
                                                      for: indexPath) as! ListViewCell

        let firstPhotoModel = viewModel.searchResult![indexPath.row*Constants.numberOfGris + 0]
        
        if let urlPath = URLPath().imageURLUsingPhotoModel(photoModel: firstPhotoModel) {
            cell.imageView1?.loadImageUsingUrlString(urlString: urlPath)
        }
        else {
            cell.imageView1 = nil
        }
    
        if indexPath.row*Constants.numberOfGris + 1 < viewModel.searchResult!.count {
     
             let secondPhotoModel = viewModel.searchResult![indexPath.row*Constants.numberOfGris + 1]
            if let urlPath = URLPath().imageURLUsingPhotoModel(photoModel: secondPhotoModel) {
                cell.imageView2?.loadImageUsingUrlString(urlString: urlPath)
            }
        }
        else {
            cell.imageView2 = nil
        }
        if indexPath.row*Constants.numberOfGris + 2 < viewModel.searchResult!.count {
        let thirdPhotoModel = viewModel.searchResult![indexPath.row*Constants.numberOfGris + 2]
            if let urlPath = URLPath().imageURLUsingPhotoModel(photoModel: thirdPhotoModel) {
                cell.imageView3?.loadImageUsingUrlString(urlString: urlPath)
            }
        }
        else{
             cell.imageView3 = nil
        }
        return cell
    }
}
