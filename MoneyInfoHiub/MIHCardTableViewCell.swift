import UIKit

class MIHCardTableViewCell: UITableViewCell {
	var card: MIHCard? {
		didSet {
			cardTitleLabel.text = card?.title ?? ""
			cardSubtitleLabel.text = card?.subtitle ?? ""
			let imageURL = card?.imageURL
			cardImageView.sd_setImage(with: imageURL)
		}
	}
	var cardImageView = FLAnimatedImageView()
	var cardgroundView = UIView()
	var cardTitleLabel = UILabel()
	var cardSubtitleLabel = UILabel()
	var cardTagLabel = UILabel()

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

		cardTitleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
		cardSubtitleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
		cardTagLabel.font = UIFont.systemFont(ofSize: 15)
		cardTagLabel.text = "#money"
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		self.contentView.addSubview(cardgroundView)
		cardgroundView.frame = self.contentView.bounds.insetBy(dx: 20, dy: 10)
		cardgroundView.layer.shadowPath = UIBezierPath(rect: cardgroundView.layer.bounds).cgPath
		cardgroundView.addSubview(cardImageView)
		var frame = cardgroundView.bounds
		frame.size.height = frame.size.width
		cardImageView.frame = frame

		cardSubtitleLabel.frame = CGRect(x: 10, y: cardgroundView.bounds.height - 90, width: cardgroundView.bounds.width - 20, height: 20)
		cardgroundView.addSubview(cardSubtitleLabel)
		cardTitleLabel.frame = CGRect(x: 10, y: cardgroundView.bounds.height - 66, width: cardgroundView.bounds.width - 20, height: 30)
		cardgroundView.addSubview(cardTitleLabel)
		cardTagLabel.frame = CGRect(x: 10, y: cardgroundView.bounds.height - 30, width: cardgroundView.bounds.width - 20, height: 20)
		cardgroundView.addSubview(cardTagLabel)
	}
}
