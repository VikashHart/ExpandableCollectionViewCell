import UIKit

protocol CellAnimatable {
    func animateCell(with view: UIView, collectionView: UICollectionView, indexPath: IndexPath, hiddenCells: [ExpandableCell], expandedCell: ExpandableCell?, toggleBool: Bool, viewController: UIViewController, completion: @escaping (CellData) -> Void)
}
