local prevSpeed = ""

function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Stutter Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'STUTTERNOTE_assets'); --Change texture
			
			setPropertyFromGroup('unspawnNotes', i, 'useSpecialSpeed', true);
			
			prevSpeed = getProperty('dynamicSpeed');
			

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
			end
		end
	end
	--debugPrint('Script started!')
end

function noteActivate(noteType)
	if getProperty('dontUpdateNoteLua') == false then
		runTimer('stutter', 0.7, 1);
	end
	setProperty('dontUpdateNoteLua', true);
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Stutter Note' then
		runTimer('oof', 0.01, 300);
	end
	setProperty('dynamicSpeed', prevSpeed);
	setProperty('dontUpdateNoteLua', false);
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Stutter Note' then
		setProperty('dynamicSpeed', prevSpeed);
		setProperty('dontUpdateNoteLua', false);
	end
end


function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'oof' then
		setProperty('health', getProperty('health') -0.005);
	end
	if tag == 'stutter' then
		setProperty('dynamicSpeed', 0);
		runTimer('stutter end', 0.3, 1);
	end
	if tag == 'stutter end' then
		setProperty('dynamicSpeed', prevSpeed + 1.5);
	end
end