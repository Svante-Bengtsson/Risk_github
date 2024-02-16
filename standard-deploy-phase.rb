require './classes.rb'

def howmanysoldiers
    antal = (($spelare[$pelaretur].length - 3)/3).round()
    if continents

    end
    return antal
end
def continents
    for i in 0...$continentes.length
        $continentes[i][-1] = 1500
    end
    for a in 0..3
        for u in 0...$continentes.length
            exitloop = 0
            for i in 0..($continentes[u].length - 3)
                if $spelare[a].index($continentes[i]) != nil
                    exitloop += 1

                end
                if exitloop == ($continentes[u].length - 2)
                    $continentes[u][-1] = a
                elsif $continentes[u][-1] >= a
                    $continentes[u][-1] = 1500
                end
            end
        end
    end
    for i in 0...$continentes.length
        p $continentes[i][-1]
    end
    for i in 0..3
        p $spelare[i]
    end
    for i in 0..$antalLander
        $lander[i].uncontinen
    end
    for i in 0...$continentes.length
        for u in 0..($continentes[i].length - 2)
            if $continentes[i][-1] != 1500
            $lander[$continentes[i][u]].continen
            end
        end
    end
end