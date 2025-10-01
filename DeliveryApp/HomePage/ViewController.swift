//
//  ViewController.swift
//  DeliveryApp
//
//  Created by Karina Kinzhigaliyeva on 02.09.2025.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
        
 
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    
    private lazy var rollsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(RollCardCell.self, forCellReuseIdentifier: "RollCardCell")
        return tableView
    }()

    
    let promos: [Promo] = [
        Promo(imageName: "Storis", title: "Скидка 10%"),  // это все верхние сторизы
        Promo(imageName: "Storis", title: "Скидка 10%"),
        Promo(imageName: "Storis", title: "Скидка 10%"),
        Promo(imageName: "Storis", title: "Скидка 10%"),
        Promo(imageName: "Storis", title: "Скидка 10%")
    ]
    
    let frequentlyOrdered: [FrequentlyOrdered] = [FrequentlyOrdered(imageName: "FrequentlyOrdered", title: "Some text", price: "50 t"), FrequentlyOrdered(imageName: "FrequentlyOrdered", title: "Some text2", price: "50 t"),FrequentlyOrdered(imageName: "FrequentlyOrdered", title: "Some text2", price: "50 t")] // часто заказываемые
    
    let categories: [Categories] = [Categories(nameOfCategories: "Суши"),Categories(nameOfCategories: "Запеченные"),Categories(nameOfCategories: "Сеты"),Categories(nameOfCategories: "Жаренные роллы")] // категории
    
    let composition: [Composition] = [Composition(image: "Storis", name: "Сливочный лосось", description: "Рис, Творожный сыр, Огурец, Нори", price: "500")] // карточка товара
    
    let rolls: [Roll] = [
        Roll(imageName: "Storis", title: "Сливочный лосось", description: "Рис, творожный сыр, нори, огурец, креветка, соус лава, унаги соус", price: "3600 ₸"), Roll(imageName: "Storis", title: "Сливочный лосось", description: "Рис, творожный сыр, нори, огурец, креветка, соус лава, унаги соус", price: "3600 ₸")]

    
    
    
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
    
    //первый collection view
    
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
    
    private lazy var frequentlyOrderedLabel: UILabel = {
        let label = UILabel()
        label.text = "Часто заказываемые"
        label.textColor = .black
        return label
    }()
    
    // второй collection view
    private lazy var frequentlyOrderedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 126, height: 217)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(FrequentlyOrderedCell.self, forCellWithReuseIdentifier: "FrequentlyOrderedCell")
        return cv
    }()
    
    // третий collection view
    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 30)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(CategoriesCell.self, forCellWithReuseIdentifier: "CategoriesCell")
        return cv
    }()
    
    
    override func viewDidLoad() {
     
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        rollsTableView.rowHeight = UITableView.automaticDimension
        rollsTableView.estimatedRowHeight = 130

        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        setupLayout()
        
        NSLayoutConstraint.activate([
            // scrollView занимает весь экран
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // contentView внутри scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)

        ])
    }
    
    private func setupLayout() {
        
        contentView.addSubview(rollsTableView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(labelAddress)
        contentView.addSubview(iconArrow)
        contentView.addSubview(bonusesButton)
        contentView.addSubview(promoCollectionView)
        contentView.addSubview(frequentlyOrderedLabel)
        contentView.addSubview(frequentlyOrderedCollectionView)
        contentView.addSubview(categoriesCollectionView)
        
        
        
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
        
        frequentlyOrderedLabel.snp.makeConstraints { make in
            make.top.equalTo(promoCollectionView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(20)
        }
        
        frequentlyOrderedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(frequentlyOrderedLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-19)
            make.height.equalTo(250)
        }
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(frequentlyOrderedCollectionView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-19)
            make.height.equalTo(30)
            
        }
        rollsTableView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(rolls.count * 130) 
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
        
        final class FrequentlyOrderedCell: UICollectionViewCell {
            
            
            private let imageView: UIImageView = {
                let iv = UIImageView()
                iv.layer.cornerRadius = 8
                iv.clipsToBounds = true
                iv.contentMode = .scaleAspectFill
                iv.backgroundColor = .lightGray
                return iv
            }()
            
            @objc private func addButtonTapped(_ sender: UIButton) {
                UIView.animate(withDuration: 0.1,
                               animations: {
                    sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                },
                               completion: { _ in
                    UIView.animate(withDuration: 0.1) {
                        sender.transform = CGAffineTransform.identity
                    }
                })
                
                print("Кнопка нажата")
            }
            
            private lazy var titleLabel: UILabel = {
                let label = UILabel()
                label.text = "Соевый соус"
                label.font = UIFont(name: "Gilroy-Bold", size: 12)
                label.textColor = .black
                return label
            }()
            
            private lazy var addButton: UIButton = {
                let button = UIButton()
                button.backgroundColor = .black
                button.setTitle("+ 300 т", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.layer.cornerRadius = 10
                button.clipsToBounds = true
                button.titleLabel?.font = UIFont(name: "Gilroy-Bold", size: 20)
                button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
                return button
            }()
            
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                contentView.addSubview(imageView)
                contentView.addSubview(titleLabel)
                contentView.addSubview(addButton)
                
                
                imageView.snp.makeConstraints { make in
                    make.top.left.right.equalToSuperview()
                    make.height.equalTo(126)
                    make.width.equalTo(126)
                }
                
                titleLabel.snp.makeConstraints { make in
                    make.top.equalTo(imageView.snp.bottom).offset(20)
                    make.height.equalTo(14)
                    make.width.equalTo(80)
                }
                
                addButton.snp.makeConstraints { make in
                    make.top.equalTo(titleLabel.snp.bottom).offset(20)
                    make.height.equalTo(37)
                    make.width.equalTo(106)
                }
                
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            func configure(with frequentlyOrdered: FrequentlyOrdered) {
                imageView.image = UIImage(named: frequentlyOrdered.imageName)
                
            }
            
        }
        
        final class CategoriesCell: UICollectionViewCell {
            
            private lazy var selectCategoryButton: UIButton = {
                let button = UIButton()
                button.setTitleColor(.white, for: .normal)
                button.titleLabel?.font = UIFont(name: "Gilroy-Regular", size: 15)
                // button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
                return button
            }()
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                contentView.addSubview(selectCategoryButton)
                contentView.backgroundColor = .black
                contentView.layer.cornerRadius = 10
                contentView.layer.masksToBounds = true
                
                selectCategoryButton.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(5)
                    
                }
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            func configure(with category: Categories) {
                selectCategoryButton.setTitle(category.nameOfCategories, for: .normal)
            }
        }
    
    final class RollCardCell: UITableViewCell {
        
        private let rollImageView = UIImageView()
        private let titleLabel = UILabel()
        private let descriptionLabel = UILabel()
        private let price = UILabel()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
            setupLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(with roll: Roll) {
            rollImageView.image = UIImage(named: roll.imageName)
            titleLabel.text = roll.title
            descriptionLabel.text = roll.description
            
            price.attributedText = NSAttributedString(
                string: roll.price,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        }
        
        private func setupViews() {
            contentView.layer.cornerRadius = 10
            contentView.backgroundColor = .white
            
            rollImageView.layer.cornerRadius = 8
            rollImageView.clipsToBounds = true
            rollImageView.contentMode = .scaleAspectFill
            
            titleLabel.font = .boldSystemFont(ofSize: 16)
            descriptionLabel.font = .systemFont(ofSize: 14)
            descriptionLabel.numberOfLines = 2
            descriptionLabel.textColor = .gray
            
            price.font = .systemFont(ofSize: 14)
            price.textColor = .lightGray
            price.font = .boldSystemFont(ofSize: 16)
            
            contentView.addSubview(rollImageView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(descriptionLabel)
            contentView.addSubview(price)
        }
        
        private func setupLayout() {
            rollImageView.snp.makeConstraints { make in
                make.top.left.equalToSuperview().inset(12)
                make.width.height.equalTo(80)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.left.equalTo(rollImageView.snp.right).offset(12)
                make.right.equalToSuperview().offset(-12)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(4)
                make.left.equalTo(titleLabel)
                make.right.equalToSuperview().offset(-12)
            }
            
            price.snp.makeConstraints { make in
                make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
                make.left.equalTo(descriptionLabel)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rolls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RollCardCell", for: indexPath) as? RollCardCell else {
            return UITableViewCell()
        }
        let roll = rolls[indexPath.row]
        cell.configure(with: roll)
        return cell
    }

}



    extension MainViewController: UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == promoCollectionView {
                return promos.count
            } else if collectionView == frequentlyOrderedCollectionView {
                return frequentlyOrdered.count
            } else if collectionView == categoriesCollectionView {
                return categories.count
            }
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == promoCollectionView {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCell", for: indexPath) as? PromoCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: promos[indexPath.item])
                return cell
            } else if collectionView == frequentlyOrderedCollectionView {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrequentlyOrderedCell", for: indexPath) as? FrequentlyOrderedCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: frequentlyOrdered[indexPath.item])
                return cell
            } else if collectionView == categoriesCollectionView {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as? CategoriesCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: categories[indexPath.item])
                return cell
            }
            
            return UICollectionViewCell()
        }
    }

