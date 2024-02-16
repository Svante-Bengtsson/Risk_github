def intface (pos, ball)
    $interface = 1
    intx = 290
    inty = 380
    whiler = 0
    fakex = 5
    $control1 = pos.clone
    $control2 = ball.clone
    @sold =  pos.clone
    @bb =ball.clone
    @intsquare = Rectangle.new(
        x: intx, y: inty,
        width: 200, height: 60,
        color: 'red',
        z: 20
    )
    @intcirc1 = Circle.new(
        x: intx + 200, y: inty +30,
        radius: 30,
        sectors: 32,
        color: 'red',
        z: 10
    )
    @intcirc2 = Circle.new(
        x: intx, y: inty +30,
        radius: 30,
        sectors: 32,
        color: 'red',
        z: 10
    )
    @intcirc3 = Circle.new(
        x: intx + 260, y: inty +30,
        radius: 25,
        sectors: 32,
        color: 'red',
        z: 10
    )
    @text1 = Text.new(
        '+',
        x: intx + 180, y: inty - 0,
        size: 50,
        color: 'black',
        z: 500
    )
    @text2 = Text.new(
        '-',
        x: intx - 10, y: inty - 10,
        size: 60,
        color: 'black',
        z: 500
    )
    @text3 = Text.new(
        'L',
        x: intx + 250, y: inty + 10,
        size: 30,
        color: 'black',
        z: 500,
        rotate: -45,
    )
    @text4 = Text.new(
        '->',
        x: intx + 85 - fakex, y: inty + 7,
        size: 40,
        color: 'black',
        z: 500
    )
    @text5 = Text.new(
        @sold,
        x: intx + 35 - fakex, y: inty + 7,
        size: 40,
        color: 'black',
        z: 500
    )
    @text6 = Text.new(
        @bb,
        x: intx + 140 - fakex, y: inty + 7,
        size: 40,
        color: 'black',
        z: 500
    )
    @soldmenu = 0
end


def intloop
    if @soldmenu == 1
        @intsquare.remove
        @intcirc1.remove
        @intcirc2.remove
        @intcirc3.remove
        @text1.remove
        @text2.remove
        @text3.remove
        @text4.remove
        @text5.remove
        @text6.remove
        $interface = 0
        @soldmenu = 0
        totsold = @sold.clone
        landsold = @bb.clone
        arr = [totsold, landsold]
        $lander[$curland].unclicked
        return arr
    elsif @soldmenu == 2
        if @bb>0 && @sold < $control1
            @sold += 1
            @bb -= 1
        end
        
        
        @text6.text = @bb
        @text5.text = @sold
        @soldmenu = 0
        
    elsif @soldmenu == 3
        if @sold>0
            
            @sold -= 1
            @bb += 1
        end
        @text6.text = @bb
        @text5.text = @sold
        @soldmenu = 0
    end 
end


def checkaagdklar
    $startaagd = 1
    
    for i in 0..$antalLander
        if $lander[i].agd == 0
            $startaagd = 0
        end
    end
end

def turcolor
    if $pelaretur == 0
        $pelareturen.color = $spelare[0][0]
    elsif $pelaretur == 1
        $pelareturen.color = $spelare[1][0]
    elsif $pelaretur == 2
        $pelareturen.color = $spelare[2][0]
    else 
        $pelareturen.color = $spelare[3][0]
    end
end
def nextturn
    check = 0
    while check == 0
        if $pelaretur.to_i < 3
            $pelaretur += 1
        else
            $pelaretur = 0
        end
        if $dod[$pelaretur.to_i] == 0
            check = 1
        end
    end
end
def showcurrsold
    $soldnumbtxt.text = $cursoldiers
end