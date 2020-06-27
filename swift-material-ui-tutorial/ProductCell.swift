import UIKit
import MaterialComponents

class ProductCell: MDCCardCollectionCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
      super.awakeFromNib()

        self.backgroundColor = .white

        self.cornerRadius = 4.0;
        self.setBorderWidth(1.0, for:.normal)
        self.setBorderColor(.lightGray, for: .normal)
    }

}
