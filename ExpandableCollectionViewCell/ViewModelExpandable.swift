import UIKit

protocol ViewModelExpandable {
    var hiddenCells: [ExpandableCell] { get set }
    var expandedCells: ExpandableCell? { get set }
    var toggleBool: Bool { get set }
    var animation: CellAnimatable { get }
}
