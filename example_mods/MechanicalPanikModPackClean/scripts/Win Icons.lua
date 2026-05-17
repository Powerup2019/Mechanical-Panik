-- make sure your icon has three frames (i.e. 450x150 image)

function onUpdatePost(elapsed)

	if getProperty('healthBar.percent') > 80 and getProperty('iconP1.numFrames') > 2 then
		setProperty('iconP1.animation.curAnim.curFrame', 2);
	end

	if getProperty('healthBar.percent') < 20 and getProperty('iconP2.numFrames') > 2 then
		setProperty('iconP2.animation.curAnim.curFrame', 2);
	end

end