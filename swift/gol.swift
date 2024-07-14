import Foundation
typealias MatLike = Array<Array<Int>>

func matdis(matrix:MatLike) {
    print("\u{001b}[1J\u{001b}[1;1H")
    for row in matrix {
        for col in row {
            if col == 1 {
                print("⬜", terminator:"")
            }else{
                print("⬛", terminator:"")
            }
        }
        print()
    }
}


func alive(matrix:MatLike,x:Int,y:Int) -> Int {
    var count = 0
    for dy in -1...1 {
        for dx in -1...1 {
            if (dx == 0 && dy == 0 ){
                continue
            }
            let newx = (x+matrix[0].count+dx) % matrix[0].count
            let newy = (y+matrix.count+dy) % matrix.count
            if (matrix[newy][newx] == 1){
                count+=1
            }
       }
    }
    return count
}


func next_step(matrix:MatLike) -> MatLike {
    var buffer = Array(repeating: Array(repeating: 0,count: matrix[0].count),count: matrix.count)
    for y in 0..<matrix.count {
        for x in 0..<matrix[0].count{
            let alive_count = alive(matrix:matrix,x:x,y:y)
            if ( alive_count == 3 ){
                buffer[y][x] = 1
            }else if alive_count==2 {
                buffer[y][x] = matrix[y][x]    
            }else {
                buffer[y][x] = 0
                    
            }
        }
    }
    return buffer

}


var matrix = [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,0,0,1,0],
        [0,1,1,1,0],
        [0,0,0,0,0],
]


for _ in 0...2000{
    matdis(matrix:matrix)
    matrix = next_step(matrix:matrix)
    Thread.sleep(forTimeInterval: 0.05)
}