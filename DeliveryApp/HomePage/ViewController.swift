//
//  ViewController.swift
//  DeliveryApp
//
//  Created by Karina Kinzhigaliyeva on 02.09.2025.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
        let promos: [Promo] = [
            Promo(imageName: "Storis", title: "Скидка 10%"),
            Promo(imageName: "Storis", title: "Скидка 10%"),
            Promo(imageName: "Storis", title: "Скидка 10%")
        ]
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "mainIcon")
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Филиал Кабанбай Батыра"
        label.textColor = .black
        return label
    }()
    
    private lazy var labelAddress: UILabel = {
        let label = UILabel()
        label.text = "Указать свой адрес"
        label.textColor = .black
        return label
    }()
    
    private lazy var iconArrow: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "arrow")
        return image
    }()
    
    private lazy var bonusesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bonuses"), for: .normal)
        return button
    }()

    private lazy var promoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 75, height: 90)
    layout.minimumLineSpacing = 8
    layout.minimumInteritemSpacing = 0

    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .clear
    cv.showsHorizontalScrollIndicator = false
    cv.dataSource = self
    cv.delegate = self
    cv.register(PromoCell.self, forCellWithReuseIdentifier: "PromoCell")
    return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(icon)
        view.addSubview(titleLabel)
        view.addSubview(labelAddress)
        view.addSubview(iconArrow)
        view.addSubview(bonusesButton)
        view.addSubview(promoCollectionView)
        
        icon.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(46)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.left.equalTo(icon.snp.right).offset(97)
            make.width.equalTo(220)
            make.height.equalTo(20)
        }
        
        labelAddress.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(165)
            make.height.equalTo(57)
        }
        
        iconArrow.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(25)
            make.left.equalTo(labelAddress.snp.right).offset(7)
            make.width.height.equalTo(24)
            make.centerY.equalTo(labelAddress)
        }
        
        bonusesButton.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(25)
            make.left.equalTo(iconArrow.snp.right).offset(80)
            make.width.equalTo(79)
            make.height.equalTo(33)
        }
        
        
        promoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(labelAddress.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-19)
            make.height.equalTo(100)

            
        }
    }

    final class PromoCell: UICollectionViewCell {

        private let imageView: UIImageView = {
            let iv = UIImageView()
            iv.layer.cornerRadius = 8
            iv.clipsToBounds = true
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = .lightGray
            return iv
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(imageView)

            imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            }
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }

        func configure(with promo: Promo) {
            imageView.image = UIImage(named: promo.imageName ?? "")
        }
    }
    
    }
    extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return promos.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCell", for: indexPath) as? PromoCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: promos[indexPath.item])
            return cell
        }
    }
    

