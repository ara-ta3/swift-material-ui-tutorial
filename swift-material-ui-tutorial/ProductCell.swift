import UIKit
import MaterialComponents

class ProductCell: MDCCardCollectionCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!

  func configureCell() {
    self.backgroundColor = .white

    self.cornerRadius = 0.0;

    self.setBorderWidth(0.0, for:.normal)
    self.setBorderColor(.lightGray, for: .normal)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    configureCell()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    configureCell()
  }

}
