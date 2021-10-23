RDX = nil

Citizen.CreateThread(function()
	while RDX == nil do
		TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)
		Citizen.Wait(10)
	end

	local GUI      = {}
	GUI.Time       = 0
	local MenuType = 'default'

	local openMenu = function(namespace, name, data)
		SendNUIMessage({
			action    = 'openMenu',
			namespace = namespace,
			name      = name,
			data      = data,
		})

	end

	local closeMenu = function(namespace, name)
		SendNUIMessage({
			action    = 'closeMenu',
			namespace = namespace,
			name      = name,
			data      = data,
		})
	end

	RDX.UI.Menu.RegisterType(MenuType, openMenu, closeMenu)

	RegisterNUICallback('menu_submit', function(data, cb)
		local menu = RDX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
		
		if menu.submit ~= nil then
			menu.submit(data, menu)
		end

		cb('OK')
	end)

	RegisterNUICallback('menu_cancel', function(data, cb)
		local menu = RDX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
		
		if menu.cancel ~= nil then
			menu.cancel(data, menu)
		end

		cb('OK')
	end)

	RegisterNUICallback('menu_change', function(data, cb)
		local menu = RDX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
		if data.elements ~= nil then
			for i=1, #data.elements, 1 do
				menu.setElement(i, 'value', data.elements[i].value)

				if data.elements[i].selected then
					menu.setElement(i, 'selected', true)
				else
					menu.setElement(i, 'selected', false)
				end

			end
		end
		if menu.change ~= nil then
			menu.change(data, menu)
		end

		cb('OK')
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10)

			if IsControlPressed(0, 0xCDC4E4E9) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({action = 'controlPressed', control = 'ENTER'})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 0x156F7119) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({action  = 'controlPressed', control = 'BACKSPACE'})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 0x6319DB71) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 200 then
				SendNUIMessage({action  = 'controlPressed', control = 'TOP'})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 0x05CA7C52) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 200 then
				SendNUIMessage({action  = 'controlPressed', control = 'DOWN'})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 0xA65EBAB4) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({action  = 'controlPressed', control = 'LEFT'})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 0xDEB34313) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({action  = 'controlPressed', control = 'RIGHT'})
				GUI.Time = GetGameTimer()
			end
		end
	end)
end)
