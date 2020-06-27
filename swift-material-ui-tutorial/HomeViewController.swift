import UIKit
import MaterialComponents

class HomeViewController: UICollectionViewController {
  var shouldDisplayLogin = true
  var appBarViewController = MDCAppBarViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView!.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")

    self.view.tintColor = .black
    self.view.backgroundColor = .white

    self.title = "Shrine"

    self.collectionView?.backgroundColor = .white

    self.addChild(self.appBarViewController)

    self.view.addSubview(self.appBarViewController.view)
    self.appBarViewController.didMove(toParent: self)

    self.appBarViewController.headerView.trackingScrollView = self.collectionView

    let menuItemImage = UIImage(named: "MenuItem")
    let templatedMenuItemImage = menuItemImage?.withRenderingMode(.alwaysTemplate)
    let menuItem = UIBarButtonItem(image: templatedMenuItemImage,
            style: .plain,
            target: self,
            action: #selector(menuItemTapped(sender:)))
    self.navigationItem.leftBarButtonItem = menuItem

    let searchItemImage = UIImage(named: "SearchItem")
    let templatedSearchItemImage = searchItemImage?.withRenderingMode(.alwaysTemplate)
    let searchItem = UIBarButtonItem(image: templatedSearchItemImage,
            style: .plain,
            target: nil,
            action: nil)
    self.navigationItem.rightBarButtonItems = [ searchItem ]
    self.view.backgroundColor = ApplicationScheme.shared.colorScheme
            .surfaceColor
    self.collectionView?.backgroundColor = ApplicationScheme.shared.colorScheme
            .surfaceColor
    MDCAppBarColorThemer.applyColorScheme(ApplicationScheme.shared.colorScheme
            , to:self.appBarViewController)

    MDCAppBarTypographyThemer.applyTypographyScheme(ApplicationScheme.shared.typographyScheme
            , to: self.appBarViewController)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if (self.collectionViewLayout is UICollectionViewFlowLayout) {
      let flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
      let HORIZONTAL_SPACING: CGFloat = 8.0
      let itemDimension: CGFloat = (self.view.frame.size.width - 3.0 * HORIZONTAL_SPACING) * 0.5
      let itemSize = CGSize(width: itemDimension, height: itemDimension)
      flowLayout.itemSize = itemSize
    }

    if (self.shouldDisplayLogin) {
      let loginViewController = LoginViewController(nibName: nil, bundle: nil)
      self.present(loginViewController, animated: false, completion: nil)
      self.shouldDisplayLogin = false
    }
  }

  // MARK - Methods
  @objc func menuItemTapped(sender: Any) {
    let loginViewController = LoginViewController(nibName: nil, bundle: nil)
    self.present(loginViewController, animated: true, completion: nil)
  }

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return Catalog.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "ProductCell",
            for: indexPath)
    if let cell = cell  as? ProductCell {
      let product = Catalog.productAtIndex(index: indexPath.row)
      cell.imageView.image = UIImage(named: product.imageName)
      cell.imageView.sizeToFit()
      cell.nameLabel.text = product.productName
      cell.priceLabel.text = product.price
      return cell
    }
    cell?.sizeToFit()
    return cell as! ProductCell
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
      self.appBarViewController.headerView.trackingScrollDidScroll()
    }
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
      self.appBarViewController.headerView.trackingScrollDidEndDecelerating()
    }
  }

  override func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                         willDecelerate decelerate: Bool) {
    let headerView = self.appBarViewController.headerView
    if (scrollView == headerView.trackingScrollView) {
      headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = self.appBarViewController.headerView
    if (scrollView == headerView.trackingScrollView) {
      headerView.trackingScrollWillEndDragging(withVelocity: velocity,
              targetContentOffset: targetContentOffset)
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // FIXME xibでやりたい
    let width: CGFloat = UIScreen.main.bounds.width / 2 - 5
    let height = width
    return CGSize(width: width, height: height)
  }
}
