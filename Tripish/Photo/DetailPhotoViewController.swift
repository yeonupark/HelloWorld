//
//  DetailPhotoViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/18.
//

import UIKit

class DetailPhotoViewController: BaseViewController {
    
    var detailPhoto: UIImage?
    
    let backgroundView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var scrollView = {
        let view = UIScrollView()
        view.minimumZoomScale = 1
        view.maximumZoomScale = 4
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        
        return view
    }()
    
    lazy var photoView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 20
        if let photo = detailPhoto {
            view.image = photo
        }
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    let dismissButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.tintColor = .black
        view.layer.cornerRadius = 15
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        view.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
    
        return view
    }()
    
    
    @objc func dismissButtonClicked() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGesture()
    }
    
    override func configure() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(photoView)
        backgroundView.addSubview(dismissButton)
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview().inset(150)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        photoView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
        dismissButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
            make.size.equalTo(30)
        }
    }
    
    func configureGesture() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
            tap.numberOfTapsRequired = 2
            photoView.addGestureRecognizer(tap)
        }
        
        @objc func doubleTapGesture() {
            if scrollView.zoomScale == 1 {
                scrollView.setZoomScale(2, animated: true)
            } else {
                scrollView.setZoomScale(1, animated: true)
            }
        }
}

extension DetailPhotoViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoView
    }
}
