require './classes.rb'

def howmanysoldiers()
    antal = (($spelare[$pelaretur].length - 3)/3).round()
    if antal < 3
        antal = 3
    end
    antal += continents($pelaretur)

    
    return antal
end
def continents(land)
    for i in 0...$continentes.length
        $continentes[i][-1] = 1500
    end
    for a in 0..3
        for u in 0...$continentes.length
            exitloop = 0
            for i in 0..($continentes[u].length - 3)
                if $spelare[a].index($continentes[u][i]) != nil
                    exitloop += 1
                end
                
                if exitloop == ($continentes[u].length - 2)
                    $continentes[u][-1] = a
                end
            end
        end
    end
    summa = 0
    for u in 0...$continentes.length
        exitloop = 0
        for i in 0..($continentes[u].length - 3)
            if $spelare[land].index($continentes[u][i]) != nil
                exitloop += 1
            end
            
            if exitloop == ($continentes[u].length - 2)
                summa += ($continentes[u].length - 2)
            end
        end
    end
    return summa
end

def updatecontinentess
    for i in 0..$antalLander
        $lander[i].uncontinen
    end
    for i in 0...$continentes.length
        for u in 0...($continentes[i].length - 2)
            if $continentes[i][-1] != 1500
            $lander[$continentes[i][u]].continen
            end
        end
    end
end