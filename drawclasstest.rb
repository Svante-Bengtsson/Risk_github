require 'ruby2d'
require './classes.rb'
require './functions.rb'
require './mouse-events.rb'
require './standard-deploy-phase.rb'
require './attack-karta.rb'






set title: "risk"
set background: 'blue'
set width: 800
set height: 500
$state = 1
$startaagd = 0
#max spelare 4
$antalspelare = 4
$dod = [0, 0, 0, 0]
$interface = 0
$klicka = 0
$exit1 = 0
$check = 0
tick = 0
$deployphase = 0
$cursoldiers = 0
$curland
$othersold = 0
$spelare = [
    ['#e100ff', '#eb78fa', '#56007a'],
    ['#ff6f00', '#fcab6d', '#a8020a'],
    ['#22fc00', '#93f783', '#248000'],
    ['#faee02', '#faf375', '#999402']
]
$pelaretur = 0

$pelareturen = Rectangle.new(
    x: 0, y: 0,
    width: 800, height: 40,
    color: 'black',
    z: 500
)
$soldnumbtxt = Text.new(
    $cursoldiers,
    x: 10, y: 0,
    size: 35,
    color: 'black',
    z: 510
)



for i in 0..$antalLander
    $lander[i] = Land.new
    $lander[i].updateCirkel($karta[i][0][0].to_i*5, $karta[i][0][1].to_i*5, $karta[i][0][2].to_i*5, $karta[i][0][3].to_i*5, $karta[i][1][0].to_i*5, $karta[i][1][1].to_i*5, $karta[i][1][2].to_i*5, $karta[i][1][3].to_i*5)
    $lander[i].start(($karta[i][0][0].to_i*5 + $karta[i][0][1].to_i*5 + $karta[i][0][2].to_i*5 + $karta[i][0][3].to_i*5)/4, ($karta[i][1][0].to_i*5 + $karta[i][1][1].to_i*5 + $karta[i][1][2].to_i*5 + $karta[i][1][3].to_i*5)/4, i, 0, 'gray', 'silver', 'gray')
    $lander[i].soldatnumb
    
end





update do
  if tick % 5 == 0
    if $state == 1
        
        /inital deploy phase/

        for i in 0..$antalLander
            $lander[i].hover_click_update_deploy
        end


    elsif $state == 2

        /standard deploy phase/
        if $deployphase == 0
            $cursoldiers = howmanysoldiers
            $deployphase = 1
        elsif $deployphase == 1
            for i in 0..$antalLander
                $lander[i].hover_click_update_deploy
            end
            lager = intloop 
            if lager != nil && lager.class == Array
                if lager.length == 2 && $interface == 0
                    $lander[$curland].sold(lager[1])
                    $cursoldiers = lager[0]
                end
            end
            
        end
        continents
        if $cursoldiers < 1
            $state = 3
        end
        
        showcurrsold

    elsif $state == 3
        intloop
    elsif $state == 4
        intloop
    end
    turcolor
    
  end
  tick += 1
end


show
