
$lander = [0, 1, 2, 3, 4, 5, 6, 7, 8,]
$antalLander = $lander.length - 1


$attacker = [
    #0
    [1, 2, 33],
    #1
    [0, 2, 3, 4],
    #2
    [0, 1, 3, 7],
    #3
    [2, 1, 4, 5, 6, 7],
    #4
    [3, 1, 5, 13],
    #5
    [3, 4, 6],
    #6
    [3, 5, 7, 8],
    #7
    [2, 3, 8, 6],
    #8
    [7, 6, 9],
]
x0 = 10
y0 = 20

x1 = 20
y1 = 20

x2 = 20
y2 = 25

x3 = 29
y3 = 25

x4 = 45
y4 = 17

x5 = 35
y5 = 25

x6 = 29
y6 = 35

x7 = 20
y7 = 35

x8 = 20
y8 = 45

$karta =[
#0
[
    #x
    [x0 + 3, x0 - 3, x0 - 5, x0 + 2 ],
    #y
    [y0 - 5, y0 - 3, y0 + 5, y0 + 6 ]
],
#1
[
     #x
     [x1 + 15, x1 - 6, x1 - 7, x1 + 10 ],
     #y
     [y1 - 6, y1 - 5, y1 + 3, y1 + 1 ]
],
#2
[
     #x
     [x2 + 7, x2 - 7, x2 - 7, x2 + 7 ],
     #y
     [y2 - 2.3, y2 - 1, y2 + 5, y2 + 4 ]
],
#3
[
     #x
     [x3 + 1, x3 - 1, x3 - 1, x3 + 7 ],
     #y
     [y3 - 3, y3 - 3, y3 + 4, y3 + 9 ]
],
#4
[
     #x
     [x4 + 7, x4 - 9, x4 - 1, x4 + 8 ],
     #y
     [y4 - 5, y4 - 2, y4 + 10, y4 + 3 ]
],
#5
[
     #x
     [x5 + 5, x5 - 2, x5 + 2, x5 + 9 ],
     #y
     [y5 - 2, y5 - 0, y5 + 9, y5 + 4 ]
],
#6
[
     #x
     [x6 + 7, x6 - 1, x6 - 7, x6 + 2 ],
     #y
     [y6 - 0, y6 - 5, y6 + 9, y6 + 7 ]
],
#7
[
     #x
     [x7 + 7, x7 - 7, x7 - 9, x7 + 1 ],
     #y
     [y7 - 5, y7 - 4, y7 + 7, y7 + 9 ]
],
#8
[
     #x
     [x8 + 1, x8 - 9, x8 - 0, x8 + 3 ],
     #y
     [y8 - 0, y8 - 2, y8 + 12, y8 + 5 ]
],

]
$continentes =
[
    [0, 1, 2, 3, 4, 5, 6, 7, 8,  
    5, 1500
],
    [5, 6, 7, 8,  
    5, 1500
],
    [10, 11, 12, 13, 14,  
    5, 1500
]
]
