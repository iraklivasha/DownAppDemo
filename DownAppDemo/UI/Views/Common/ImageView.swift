//
//  ImageVIew.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import UIKit
import SDWebImage

class ImageView : UIImageView {
    
    private(set) var url: URL?
    private let context = CIContext(options: nil)
    private var originalImage: UIImage?
    
    init() {
        super.init(frame: CGRect.zero)
        self.configure()
    }
    
    init(url: String?) {
        super.init(frame: CGRect.zero)
        self.configure()
        setImageFromUrl(url, placeholderImg: nil, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    func configure() {
        self.clipsToBounds  = true
        self.contentMode    = .scaleAspectFill
    }
    
    func setDefaultImage(_ image: UIImage?) {
        self.image = image
    }
    
    func blurEffect(_ radius: Double = 10) {
        guard let image = self.image,
                let currentFilter = CIFilter(name: "CIGaussianBlur"),
                    let cropFilter = CIFilter(name: "CICrop") else { return }
        
        let beginImage = CIImage(image: image)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(radius, forKey: kCIInputRadiusKey)

        cropFilter.setValue(currentFilter.outputImage, forKey: kCIInputImageKey)
        cropFilter.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")

        guard let output = cropFilter.outputImage,
              let cgimg = context.createCGImage(output, from: output.extent) else { return }
        
        self.originalImage = image
        
        let processedImage = UIImage(cgImage: cgimg)
        self.image = processedImage
    }
    
    func removeBlur() {
        if let image = originalImage {
            self.image = image
        }
    }
    
    func cancelLoad() {
        self.sd_cancelCurrentImageLoad()
    }
    
    func setImageFromUrl(_ url: String?, placeholderImg : UIImage? = nil, completion:((_ image: UIImage?, _ error: Error?)->Void)?=nil) {
        
        if let _url = url, !_url.isEmpty {
            if let __url = URL(string: _url) {
                self.url = __url
                self.sd_setImage(with: __url,
                                 placeholderImage: placeholderImg,
                                 options: .queryDiskDataSync, progress: nil) { (img, err, type, url) in
                    if err == nil {
                        self.contentMode = .scaleAspectFill
                    }
                    completion?(img, err)
                }
            } else {
                self.url = nil
                self.image = placeholderImg
                self.contentMode = .scaleAspectFit
                completion?(nil, DownError.invalidURL)
            }
        } else {
            self.url = nil
            self.image = placeholderImg
            self.contentMode = .scaleAspectFit
            completion?(placeholderImg, DownError.invalidURL)
        }
    }
    
}

class CircleImageView: ImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.height / 2
    }
}
