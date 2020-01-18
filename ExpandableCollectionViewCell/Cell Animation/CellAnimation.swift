import UIKit

class CellAnimation: CellAnimatable {

    func animateCell(with view: UIView, collectionView: UICollectionView, indexPath: IndexPath, hiddenCells: [ExpandableCell], expandedCell: ExpandableCell?, toggleBool: Bool, viewController: UIViewController, completion: @escaping (CellData) -> Void) {

        var hiddenCells = hiddenCells
        var expandedCell = expandedCell
        var toggleBool = toggleBool

        let dampingRatio: CGFloat = 0.8
        let initialVelocity: CGVector = CGVector.zero
        let springParameters: UISpringTimingParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springParameters)

        view.isUserInteractionEnabled = false

        // Collapse animation
        if let selectedCell = expandedCell {
            toggleBool = false

            animator.addAnimations {
                selectedCell.collapse()

                for cell in hiddenCells {
                    cell.show()
                }
            }

            animator.addCompletion { _ in
                collectionView.isScrollEnabled = true

                expandedCell = nil
                hiddenCells.removeAll()
                completion(CellData(hiddenCells: hiddenCells, expandedCell: expandedCell, toggleBool: toggleBool))
            }
        } else {
            toggleBool = true

            collectionView.isScrollEnabled = false

            // Expand animation
            let selectedCell = collectionView.cellForItem(at: indexPath)! as! ExpandableCell
            let frameOfSelectedCell = selectedCell.frame

            expandedCell = selectedCell
            hiddenCells = collectionView.visibleCells.map { $0 as! ExpandableCell }.filter { $0 != selectedCell }

            animator.addAnimations {
                selectedCell.expand(in: collectionView)

                for cell in hiddenCells {
                    cell.hide(in: collectionView, frameOfSelectedCell: frameOfSelectedCell)
                }
            }
            completion(CellData(hiddenCells: hiddenCells, expandedCell: expandedCell, toggleBool: toggleBool))
        }

        animator.addAnimations {
            viewController.setNeedsStatusBarAppearanceUpdate()
        }

        animator.addCompletion { _ in
            view.isUserInteractionEnabled = true
        }

        animator.startAnimation()
    }
}
