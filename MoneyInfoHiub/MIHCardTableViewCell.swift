import UIKit

class MIHCardTableViewCell: UITableViewCell {
	var card: MIHCard? {
		didSet {
			if let imageURL = card?.imageURL {
				cardImageView.sd_setImage(with: imageURL)
			}
		}
	}
	var cardImageView = FLAnimatedImageView()
	var cardgroundView = UIView()

	override func prepareForReuse() {
		super.prepareForReuse()
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		cardgroundView.backgroundColor = UIColor.white
		cardgroundView.layer.shadowOpacity = 0.5
		cardgroundView.layer.shadowColor = UIColor.black.cgColor
		cardgroundView.layer.shadowRadius = 5
		cardgroundView.layer.shadowPath = UIBezierPath(rect: cardImageView.layer.bounds).cgPath
		cardgroundView.layer.masksToBounds = false

		cardImageView.layer.borderWidth = 1.0
		cardImageView.layer.borderColor = UIColor.gray.cgColor
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		self.contentView.addSubview(cardgroundView)
		cardgroundView.frame = self.contentView.bounds.insetBy(dx: 20, dy: 20)
		cardgroundView.layer.shadowPath = UIBezierPath(rect: cardgroundView.layer.bounds).cgPath
		cardgroundView.addSubview(cardImageView)
		var frame = cardgroundView.bounds
		frame.size.height -= 50
		cardImageView.frame = frame
	}
}
