//
//  EventTableViewCell.swift
//  Upcoming Events
//
//  Created by Alexander Camacho on 7/29/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    static let identifier = "EventTableViewCell"
    
    var event: Event = .init()
    
    private lazy var eventCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .cardBackground
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.backgroundColor = .cardBackground
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 3
        label.backgroundColor = .cardBackground
        label.textColor = .appLightGray
        return label
    }()
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.backgroundColor = .cardBackground
        label.text = "⚠️"
        label.isHidden = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(warningLabel)
        contentView.addSubview(eventCardView)
        eventCardView.addSubview(titleLabel)
        eventCardView.addSubview(timeLabel)
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with event: Event) {
        self.event = event
        
        titleLabel.text = event.title
        timeLabel.text = "\(DateFormatter.hhMMa.string(from: event.startDate)) - \(DateFormatter.hhMMa.string(from: event.endDate))"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var paddings = DesignConstants.paddings
        if event.hasConflict {
            paddings.top = 0
            paddings.left = 60
            paddings.bottom = 25
            warningLabel.isHidden = false
        }
        
        eventCardView.frame = bounds.inset(by: paddings)
        
        let widthWithMargin: CGFloat = eventCardView.frame.width - (DesignConstants.margins.left + DesignConstants.margins.right)
        var offsetY = DesignConstants.spacing
        
        titleLabel.frame = CGRect(x: DesignConstants.margins.left,
                                  y: offsetY,
                                  width: widthWithMargin,
                                  height: DesignConstants.labelHeight)
        offsetY += titleLabel.frame.height
        
        timeLabel.frame = CGRect(x: DesignConstants.margins.left,
                                  y: offsetY,
                                  width: widthWithMargin,
                                  height: DesignConstants.labelHeight)
        
        warningLabel.frame = CGRect(x: DesignConstants.paddings.left,
                                  y: 0,
                                  width: DesignConstants.warningSize,
                                  height: DesignConstants.warningSize)
        warningLabel.center.y = eventCardView.center.y
        
        setupCardView()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        timeLabel.text = nil
        warningLabel.isHidden = true
    }
    
    private func setupCardView() {
        let shadowColor: UIColor = event.hasConflict ? .red : .black
        eventCardView.layer.masksToBounds = false
        eventCardView.layer.shadowColor = shadowColor.cgColor
        eventCardView.layer.shadowOpacity = 0.2
        eventCardView.layer.shadowOffset = CGSize(width: -1, height: 1)
        eventCardView.layer.shadowRadius = 4
        eventCardView.layer.shadowPath = UIBezierPath(rect: eventCardView.bounds).cgPath
        eventCardView.layer.shouldRasterize = true
        eventCardView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private enum DesignConstants {
        static let paddings = UIEdgeInsets(top: 15, left: 15, bottom: 5, right: 15)
        static let margins = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        static let spacing: CGFloat = 8
        static let labelHeight: CGFloat = 20
        static let warningSize: CGFloat = 35
    }
}
