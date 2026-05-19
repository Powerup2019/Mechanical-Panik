function onCreatePost() {
    callOnHScript('setDropShadowShader', [boyfriend, 0, 0, 1, 'FFFFFF', -0, -100, -65, 100]);
    callOnHScript('setDropShadowShader', [gf, 0, 0, 1,'FFFFFF', 0, -100, -65, 100]);
    callOnHScript('setDropShadowShader', [dad, 0, 0, 1, 'FFFFFF', 0, -100, -65, 100]);

    healthBar.visible = iconP1.visible = iconP2.visible = timeTxt.visible = scoreTxt.visible = timeBar.visible = false;

    callOnLuas('addHScriptFromHScript', ['custom_events/RGB Change']);
    callOnHScript('onEvent', ['RGB Change', 'Both', 'BW', 0]);
}

function onGameOver() {
    callOnHScript('setDropShadowShader', [boyfriend, 0, 0, 1, 'FFFFFF', -0, -100, -65, 100]);
}