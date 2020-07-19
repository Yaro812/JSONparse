//
//  Created by Thorax on 19.07.2020.
//

import JSONtoCSVcore

let tool = JSONtoCSV()

do {
    try tool.run()
} catch {
    print("An error occured: \(error)")
}
