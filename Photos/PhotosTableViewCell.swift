//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Саша on 24.05.2022.
//

import UIKit

protocol PhotosTableViewCellDelegate: AnyObject {
    func buttonTap()
}

class PhotosTableViewCell: UITableViewCell {
    
    weak var delegate: PhotosTableViewCellDelegate?
    let imageModel = ImageModel.addImage()
    
    private lazy var collectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        let viewCollection = UICollectionView(frame: .zero ,collectionViewLayout: layoutCollection)
        viewCollection.translatesAutoresizingMaskIntoConstraints = false
        viewCollection.dataSource = self
        viewCollection.delegate = self
        viewCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return viewCollection
    }()
    
     private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.addTarget(self, action: #selector(goToGallery), for: .touchUpInside)
        return button
    }()
    
    private let labelText: UILabel = {
        let labelText = UILabel()
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.textColor = .black
        labelText.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return labelText
    }()
    
    @objc private func goToGallery() {
        delegate?.buttonTap()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupLabel(_ label: String) {
        labelText.text = "Photo"
    }
    
    private func setupLayout() {
        [collectionView, labelText, button] .forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
      
            collectionView.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12 - 8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12 + 8),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            

            labelText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            labelText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            button.centerYAnchor.constraint(equalTo: labelText.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
}


extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupImageModel(imageModel[indexPath.item])
        return cell
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    var sideInset: CGFloat {return 8}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.width - sideInset * 3) / 4
        return CGSize(width: height, height: height)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.item)
    }
}
