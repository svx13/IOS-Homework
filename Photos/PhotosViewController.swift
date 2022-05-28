//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Саша on 24.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    
    var imageModel = ImageModel.addImage()
    
    private lazy var photoCollection: UICollectionView = {
        let layoutForCollection = UICollectionViewFlowLayout()
        let collectionGallery = UICollectionView(frame: .zero, collectionViewLayout: layoutForCollection )
        collectionGallery.translatesAutoresizingMaskIntoConstraints = false
        collectionGallery.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionGallery.dataSource = self
        collectionGallery.delegate = self
        return collectionGallery
    }()
    
    private lazy var buttonCancel: UIButton = {
        $0.layer.opacity = 0
        $0.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        $0.addTarget(self, action: #selector(cancelAnimationButton), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        return $0
    }(UIButton())
    
    private let blackView: UIView = {
        //let view = UIView()
        $0.frame = UIScreen.main.bounds
        $0.backgroundColor = .black
        $0.alpha = 0.8
        $0.isUserInteractionEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.opacity = 0
        return $0
    }(UIView())
    
    var fullScreenImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "photo1"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 0
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Photo Gallery"
        setupLayout()
    }
    
    private func setupLayout() {
        
        [photoCollection, blackView, fullScreenImageView, buttonCancel].forEach({view.addSubview($0)})
 
        NSLayoutConstraint.activate([
            photoCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fullScreenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullScreenImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fullScreenImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            fullScreenImageView.heightAnchor.constraint(equalTo: fullScreenImageView.widthAnchor, multiplier: 1),

            buttonCancel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            buttonCancel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            buttonCancel.widthAnchor.constraint(equalToConstant: 40),
            buttonCancel.heightAnchor.constraint(equalTo: buttonCancel.widthAnchor, multiplier: 1)
        ])
    }
}


extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupImageModel(imageModel[indexPath.item])
        cell.buttonAllPhotoCellDelegate = self
        
        return cell
    }
}


extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
}


extension PhotosViewController: PhotoCellDelegate {
    
    func tapAction(photo: UIImage) {
        self.fullScreenImageView.image = photo
        self.fullScreenImageView.isUserInteractionEnabled = true
        self.navigationController?.isNavigationBarHidden = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            
            self.blackView.layer.opacity = 0.85
            self.fullScreenImageView.layer.opacity = 1
            self.view.layoutIfNeeded()
            
        } completion: { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0.0) {
                self.buttonCancel.layer.opacity = 1
            }
        }
    }
    
    @objc func cancelAnimationButton() {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            self.buttonCancel.layer.opacity = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0.0) {
                self.blackView.layer.opacity = 0.0
                self.fullScreenImageView.layer.opacity = 0
                self.navigationController?.isNavigationBarHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
}
