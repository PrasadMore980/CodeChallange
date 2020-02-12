//
//  CountryInfoTableViewCell.swift
//  TelstraCodeExercise
//
//  Created by Prasad More on 12/02/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

class CountryInfoTableViewCell: UITableViewCell {


    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleText: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var descriptionText: String? {
        get {
            return descriptionLabel.text
        }
        set {
            descriptionLabel.text = newValue
        }
    }
    var rowElement: Rows? {
        didSet {
            guard let rowElement = rowElement else {
                return
            }
            self.titleText = rowElement.title
            self.descriptionText = rowElement.description
            self.cellImage.image = UIImage.init(named: "placeholder")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(cellImage)
        setcelllayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    func setcelllayout()  {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: Height.infoTableCellMinimum),
            
            cellImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Paddings.LeadTop),
            cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Paddings.LeadTop),
            cellImage.widthAnchor.constraint(equalToConstant: CGFloat(ImageSize.width)),
            cellImage.heightAnchor.constraint(equalToConstant: CGFloat(ImageSize.height)),
            
            titleLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: Paddings.LeadTop),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Paddings.LeadTop),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  Paddings.TrailBottom),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Paddings.LeadTop),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Paddings.TrailBottom)
            ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
