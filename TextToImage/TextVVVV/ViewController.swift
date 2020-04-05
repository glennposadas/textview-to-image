//
//  ViewController.swift
//  TextVVVV
//
//  Created by Glenn Von Posadas on 4/6/20.
//  Copyright © 2020 GroundCrew. All rights reserved.
//

import AVFoundation
import UIKit

var frameOfImageProcess: CGRect = .zero

class ViewController: UIViewController {

    @IBOutlet weak var scrollVwFrame: UIScrollView!
    @IBOutlet var imgvwFrame : UIImageView! // set tag 1001
    
    @IBAction func addText(_ sender: Any) {
        (self.scrollVwFrame as! JLStickerImageView).addLabel()
        
        guard let lastTextView = self.findLastTextView() else { return }
        
        self.scrollVwFrame.isScrollEnabled = false
        
        for gesture in self.scrollVwFrame.gestureRecognizers! {
            gesture.isEnabled = false
        }
    }
    
    func findLastTextView() -> JLAttributedTextView? {
        if let currentlyEditingLabel = (self.scrollVwFrame as! JLStickerImageView).currentlyEditingLabel {
            return currentlyEditingLabel.labelTextView!
        }
        
        return (self.scrollVwFrame as! JLStickerImageView).labels.last?.labelTextView ?? nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollVwFrame.maximumZoomScale = 1.0
        scrollVwFrame.minimumZoomScale = 0.5
        
        self.scrollVwFrame.delegate = self
        scrollVwFrame.contentSize = imgvwFrame.frame.size
        
        let imageSize = self.imgvwFrame.image?.size ?? .zero
        frameOfImageProcess = AVMakeRect(aspectRatio: imageSize, insideRect: self.imgvwFrame.frame)
    }
}

//MARK:- Scrollview

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if scrollView == self.scrollVwFrame {
            return self.imgvwFrame
        }
        
        return nil
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }
}

