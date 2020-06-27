import UIKit
import MaterialComponents

class ProductCell: MDCCardCollectionCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!

  func configureCell() {
    self.backgroundColor = .white

    //TODO: Set custom font based on our ApplicationScheme and center align text
    //TODO: Set to 0 to disable the curved corners
    self.cornerRadius = 4.0;

    //TODO: Set Border Width to 0 to disable the stroke outline
    self.setBorderWidth(1.0, for:.normal)
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
