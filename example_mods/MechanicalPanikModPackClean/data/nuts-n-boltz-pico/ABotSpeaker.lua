--[[
        *\  Script Creado Por Perez Sen  /* 

        Pagina Official de Scripts / Official Script Page : https://sites.google.com/view/ports-by-perez-sen/ports-psych-engine?authuser=0#h.to365mv6t7h
        YOUTUBE : https://youtube.com/@perez_sen?si=zVnv-2Kn4UqMdYvG

        Si lo piensas compartir solo pon el link hacia el video del script en cuention Gracias.

        If you plan to share it, just put the link to the script video in question. Thanks

        Se quiser compartilhar, basta colocar o link do vídeo do roteiro em questão. Obrigado.
]]--

function onCreatePost()
    createInstance("AbotLua", "states.stages.objects.ABotSpeaker",{0,0});
    setProperty("AbotLua.x", getProperty("gf.x")-0);
    setProperty("AbotLua.y", getProperty("gf.y")+210);
    addInstance("AbotLua",false);
    setObjectOrder("AbotLua",getObjectOrder("gf")+7)
end

function onSongStart()
    runHaxeCode([[
       getVar("AbotLua").snd = FlxG.sound.music; // Entrada de Musica No Mover
    ]]);
end

function onMoveCamera(isDad)
    eyesCheck(isDad);
end

function eyesCheck(ojo)
    if ojo == 'dad' then
   callMethod("AbotLua.lookLeft");
    else
        callMethod("AbotLua.lookRight") ;
    end
end