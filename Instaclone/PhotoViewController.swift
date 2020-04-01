//
//  PhotoViewController.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 01.04.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var magnifiedImage: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        magnifiedImage.image = tappedImage
        scrollView.maximumZoomScale = 2
        scrollView.minimumZoomScale = 1
        scrollView.delegate = self
    }

}

extension PhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return magnifiedImage
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.zoomScale = 1
    }
}
