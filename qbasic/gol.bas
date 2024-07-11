Screen 0
SIZE = 5
Dim matrix(1 To SIZE, 1 To SIZE) As Integer, buffer(1 To SIZE, 1 To SIZE) As Integer
' [ 0,0,0,0,0]
' [ 0,0,1,0,0]
' [ 0,0,0,1,0]
' [ 0,1,1,1,0]
' [ 0,0,0,0,0]
matrix(1, 2) = 1
matrix(2, 3) = 1
matrix(3, 3) = 1
matrix(3, 2) = 1
matrix(3, 1) = 1

For mmi = 0 To 1000
    Cls
    For y = 1 To UBound(matrix)
        For x = 1 To SIZE
            Let alive_cont = 0
            dx = 1
            dy = 1
            newx = (x + dx + SIZE) Mod UBound(matrix) + 1
            newy = (y + dy + SIZE) Mod UBound(matrix) + 1
            If matrix(newx, newy) = 1 Then
                alive_count = alive_count + 1
            End If

            dx = 1
            dy = 0
            newx = (x + dx + SIZE) Mod UBound(matrix) + 1
            newy = (y + dy + SIZE) Mod UBound(matrix) + 1
            If matrix(newx, newy) = 1 Then
                alive_count = alive_count + 1
            End If
            dx = 1
            dy = -1
            newx = (x + dx + SIZE) Mod UBound(matrix) + 1
            newy = (y + dy + SIZE) Mod UBound(matrix) + 1
            If matrix(newx, newy) = 1 Then
                alive_count = alive_count + 1
            End If
            dx = -1
            dy = 1
            newx = (x + dx + SIZE) Mod UBound(matrix) + 1
            newy = (y + dy + SIZE) Mod UBound(matrix) + 1
            If matrix(newx, newy) = 1 Then
                alive_count = alive_count + 1
            End If
            dx = -1
            dy = 0
            newx = (x + dx + SIZE) Mod UBound(matrix) + 1
            newy = (y + dy + SIZE) Mod UBound(matrix) + 1
            If matrix(newx, newy) = 1 Then
                alive_count = alive_count + 1
            End If
            dx = -1
            dy = -1
            newx = (x + dx + SIZE) Mod UBound(matrix) + 1
            newy = (y + dy + SIZE) Mod UBound(matrix) + 1
            If matrix(newx, newy) = 1 Then
                alive_count = alive_count + 1
            End If
            dx = 0
            dy = 1
            newx = (x + dx + SIZE) Mod UBound(matrix) + 1
            newy = (y + dy + SIZE) Mod UBound(matrix) + 1
            If matrix(newx, newy) = 1 Then
                alive_count = alive_count + 1
            End If
            dx = 0
            dy = -1
            newx = (x + dx + SIZE) Mod UBound(matrix) + 1
            newy = (y + dy + SIZE) Mod UBound(matrix) + 1
            If matrix(newx, newy) = 1 Then
                alive_count = alive_count + 1
            End If

            ' Print alive_count; " ";
            If alive_count = 3 Then
                buffer(y, x) = 1
            ElseIf alive_count = 2 Then
                buffer(y, x) = matrix(y, x)
            Else
                buffer(y, x) = 0
            End If
            alive_count = 0
        Next x
        'Print
    Next y
    Print
    Print
    Print
    Print
    GoTo copy_buffer
    copy_back:
    GoTo printer
    back:
    Sleep 0.5
Next mmi
End

printer:
For ppi = 1 To SIZE
    For ppj = 1 To SIZE
        If (matrix(ppi, ppj) = 1) Then
            Print ("#");
        Else
            Print ("_");
        End If
        ' Print (matrix(i, j));
    Next ppj
    Print ("")
Next ppi
GoTo back

copy_buffer:
For lli = 1 To SIZE
    For llj = 1 To SIZE
        matrix(lli, llj) = buffer(lli, llj)
    Next llj
Next lli
GoTo copy_back




