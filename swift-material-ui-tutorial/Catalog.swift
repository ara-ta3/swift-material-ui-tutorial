import UIKit

class Product: NSObject {
  public private(set) var imageName: String
  public private(set) var productName: String
  public private(set) var price: String
  public private(set) var category: String
  public private(set) var isFeatured: Bool

  required init(imageName: String, productName: String, price: String, category: String, isFeatured: Bool) {
    self.imageName = imageName
    self.productName = productName
    self.price = price
    self.category = category
    self.isFeatured = isFeatured
    super.init()
  }
}

class Catalog: NSObject {
  // Notification that gets posted when categoryFilter is changed
  public static let CatalogFilterDidChangeNotification: Notification.Name =
          Notification.Name(rawValue: "CatalogFilterDidChangeNotification")

  private static let products = [
    Product(imageName: "Product0", productName: "Vagabond sack", price: "$120", category: "Accessories", isFeatured:true),
    Product(imageName: "Product1", productName: "Stella sunglasses", price: "$58", category: "Accessories", isFeatured:true),
    Product(imageName: "Product2", productName: "Whitney belt", price: "$35", category: "Accessories", isFeatured:false),
    Product(imageName: "Product3", productName: "Garden strand", price: "$98", category: "Accessories", isFeatured:true),
    Product(imageName: "Product4", productName: "Strut earnings", price: "$34", category: "Accessories", isFeatured:false),
    Product(imageName: "Product5", productName: "Varsity socks", price: "$12", category: "Accessories", isFeatured:false),
    Product(imageName: "Product6", productName: "Weave keyring", price: "$16", category: "Accessories", isFeatured:false),
    Product(imageName: "Product7", productName: "Gatsby hat", price: "$40", category: "Accessories", isFeatured:true),
    Product(imageName: "Product8", productName: "Shrug bag", price: "$198", category: "Accessories", isFeatured:true),
    Product(imageName: "Product9", productName: "Gilt desk trio", price: "$58", category: "Home", isFeatured:true),
  ]

  private static var filteredProducts: [Product] = products

  static var count: Int {
    return Catalog.filteredProducts.count
  }

  public static func productAtIndex(index: Int) -> Product {
    return Catalog.filteredProducts[index]
  }

  static var categoryFilter: String = "" {
    didSet(newFilter) {
      self.applyFilter()
      NotificationCenter.default.post(name: CatalogFilterDidChangeNotification, object: nil)
    }
  }

  class func applyFilter() {
    self.filteredProducts.removeAll()
    for product in self.products {
      if (self.categoryFilter == "" || self.categoryFilter == "Featured") && product.isFeatured {
        self.filteredProducts.append(product)
      } else if product.category == self.categoryFilter {
        self.filteredProducts.append(product)
      }
    }
  }
}
