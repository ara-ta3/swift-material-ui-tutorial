import UIKit
import MaterialComponents

class HomeViewController: UICollectionViewController {
  var shouldDisplayLogin = true
  var appBarViewController = MDCAppBarViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView!.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")

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
    //TODO: Set the number of cells to be equal to the number of products in the catalog
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "ProductCell",
            for: indexPath) as! ProductCell
    //TODO: Set the properties of the cell to reflect to product from the model

    return cell
  }
}

extension HomeViewController {

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
}
