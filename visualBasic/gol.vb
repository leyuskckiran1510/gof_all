Imports System.Collections.Generic

Module VBModule 
    Public Sub Main()
        Dim matrix(4,4) As Integer
        matrix(1,2) = 1
        matrix(2,3) = 1
        matrix(3,3) = 1
        matrix(3,2) = 1
        matrix(3,1) = 1
        For i AS Integer = 1 to 1000
            Matprint(matrix)
            NextStep(matrix)
            Threading.Thread.Sleep(100)
        Next
    End Sub

    Private Sub NextStep(ByRef matrix(,) AS Integer)
        Dim tempbufer(4,4) AS Integer
        Dim alive_count AS Integer = 0
        Dim row As Integer = 0
        Dim col AS Integer = 0 
        For index As Integer = 0 to matrix.length-1
            alive_count = Alive(matrix,row,col)
            If alive_count = 3 Then
                tempbufer(row,col) = 1
            ElseIf alive_count = 2 Then
                tempbufer(row,col) = matrix(row,col)
            Else  
                tempbufer(row,col) = 0
            End If
            col = col + 1
            If (index+1) mod 5 = 0 Then
                row = row + 1
                col = 0
            End if
        Next index
        matrix = tempbufer
    End Sub

    Private Sub Matprint(matrix(,) As Integer)
        Dim row As Integer = 0
        Dim col AS Integer = 0
        Console.Clear()
        For index As Integer = 0 to matrix.length-1
            If matrix(row,col) = 1 Then
                Console.Write("⬜")
            Else    
                Console.Write("⬛")
            End If
            col = col + 1
            If (index+1) mod 5 = 0 Then
                Console.WriteLine("")
                row = row + 1
                col = 0
            End if
        Next index
        Console.WriteLine("")
    End Sub


    Private Function Alive(matrix(,) As Integer,y As Integer,x as Integer) As Integer
        DIM alives AS Integer = 0
        Dim newx As Integer = 0
        Dim newy As Integer = 0
        For dx AS Integer = -1 to 1 
            FOR dy As Integer = -1 to 1
                If dx=0 And dy= 0 THEN
                    CONTINUE FOR
                End If
                newx = (x + dx + 5) mod 5
                newy = (y + dy + 5) mod 5
                IF  matrix(newy,newx) = 1 THEN
                   alives = alives + 1 
                END IF
            Next dy
        Next dx
        Return alives
    End Function
End Module