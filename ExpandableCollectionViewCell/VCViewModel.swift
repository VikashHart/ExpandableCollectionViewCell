import UIKit

class VCViewModel: ViewModelExpandable {

    private(set) var cellSpacing: CGFloat
    private(set) var numberOfCells: CGFloat
    private(set) var numberOfSpaces: CGFloat

    var hiddenCells: [ExpandableCell] = []
    var expandedCells: ExpandableCell?
    var toggleBool: Bool = false
    private(set) var animation: CellAnimatable

    init(cellSpacing: CGFloat = 20,
         numberOfCells: CGFloat = 1,
         animation: CellAnimatable = CellAnimation()) {
        self.cellSpacing = cellSpacing
        self.numberOfCells = numberOfCells
        self.numberOfSpaces = numberOfCells + 1
        self.animation = animation
    }
}
