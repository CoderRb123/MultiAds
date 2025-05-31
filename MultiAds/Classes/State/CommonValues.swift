import Foundation


@available(iOS 13.0, *)
public class CommonChangables : ObservableObject{
     public static let shared = CommonChangables()
    @Published  public var onComplete: ()->Void = {}
    
    @Published  public  var routeIndex:Dictionary<String,Int> = Dictionary()
    @Published  public var selectedScracher: String?
    @Published  public var adLoader: Bool = false
    
    @Published  public var collectedStickers: [String] = ["https://miracocopepsi.com/admin/mayur/coc/pradip/ios/dicedream_vinod/stickers/category_4/5.png"]
    @Published  public var userDice: Int = 75
    
}
    
