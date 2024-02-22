

# Här requirerar jag alla relevanta filer och ruby2d så att jag kan hänvisa till metoderna däri i min game-loop senare
require 'ruby2d'
require './classes.rb'
require './functions.rb'
require './mouse-events.rb'
require './standard-deploy-phase.rb'
require './attack-karta2.rb'


# här initierar jag antal spelare detta kan ändras mellan 2 och 4
# max spelare 4
$antalspelare = 2

# här initierar jag alla startvariabler samt vad fönstret ska heta, bakrundsfärg, min spelar-lista, samt höjd och bredd av fönstret.
set title: "risk"
set background: 'blue'
set width: 800
set height: 500
$state = 1
$startaagd = 0
$antalpelareclock = $antalspelare.clone - 1
$exitinitdepl = (($lander.length.to_i * 2)/$antalspelare.to_i).round
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
$clickstate3 = 0
$savestateattack = nil
$spelare = [
    ['#e100ff', '#eb78fa', '#56007a'],
    ['#ff6f00', '#fcab6d', '#a8020a'],
    ['#22fc00', '#93f783', '#248000'],
    ['#faee02', '#faf375', '#999402']
]
$pelaretur = 0

# Här skapar jag delar av interface-et samt kör setuptoptext som också startar en del av interfacet
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
setuptoptxt


# här initierar jag alla länders startvariabler samt skapar länderna på kartan och sätter på startnumret av soldater dvs 0
for i in 0..$antalLander
    $lander[i] = Land.new
    $lander[i].updateCirkel($karta[i][0][0].to_i*5, $karta[i][0][1].to_i*5, $karta[i][0][2].to_i*5, $karta[i][0][3].to_i*5, $karta[i][1][0].to_i*5, $karta[i][1][1].to_i*5, $karta[i][1][2].to_i*5, $karta[i][1][3].to_i*5)
    $lander[i].start(($karta[i][0][0].to_i*5 + $karta[i][0][1].to_i*5 + $karta[i][0][2].to_i*5 + $karta[i][0][3].to_i*5)/4, ($karta[i][1][0].to_i*5 + $karta[i][1][1].to_i*5 + $karta[i][1][2].to_i*5 + $karta[i][1][3].to_i*5)/4, i, 0, 'gray', 'silver', 'gray')
    $lander[i].soldatnumb
    
end

# här börjar game-loopen
update do
# här sätter jag sätter jag så att jag inte kör hela koden varje tick utan istället bara var femte tick
  if tick % 5 == 0
# kör toptextupdate så att texten längst upp visar vilken fas man befinner sig i
    toptextupdate
    if $state == 1
        
        /inital deploy phase/
        # Det här är initial deploy phase, den hanteras till 99% i mouse-events men den finns fortfarande här så att jag kan updatera interfacet. Denna fasen händer bara en gång per spel sen loopas de andra faserna

        for i in 0..$antalLander
            $lander[i].hover_click_update_deploy
            updatecontinentess
            continents(0)
        end
        

    elsif $state == 2
        
        /standard deploy phase/
        # här hanterars framförallt hur många soldater man får och att sätta ut dem. när antal soldater att sätta ut når 0 så går man vidare till nästa fas och skapar en knapp som snvänds för att gå vidare till fasen efter det

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
        updatecontinentess
        if $cursoldiers < 1
            $state = 3
            createbutton
        end
        
        showcurrsold

    elsif $state == 3
        
        /Attack Phase/
        # här hanteras bara flyttningen av enheter till det nya landet efter att man attackerat, resten sköts i mouse-events

        lager = intloop2
        if lager != nil && lager.class == Array
            if lager.length == 2 && $interface == 0
                $lander[$savestateattack].sold(lager[0])
                $lander[$attackedsave].sold(lager[1])
                dodcheck
            end
        end
        updatecontinentess
        showcurrsold
        for i in 0..$antalLander
            $lander[i].hover_click_update_attack
        end
    elsif $state == 4
        
        /Fortify Phase/
        # nästan exakt samma sak som  Attack fasen då det viktiga hanteras i mouse-events 

        lager = intloop3
        if lager != nil && lager.class == Array
            if lager.length == 2 && $interface == 0
                $lander[$savestateattack].sold(lager[0])
                $lander[$attackedsave].sold(lager[1])
                dodcheck
            end
        end
        updatecontinentess
        showcurrsold
        for i in 0..$antalLander
            $lander[i].hover_click_update_fortify
        end
    end
    turcolor
    
  end
  tick += 1
end


show
