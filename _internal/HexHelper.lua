local hexhelper={}

function hexhelper.assembleConfig(win,tab,hexmeta)
		tab:AddParagraph({
			Title = "About HexHub",
			Content = "All the information about the currenly running client"
		})
		
end

function hexhelper.joinServer()
	local Request = http_request or syn and syn.request or request or nil
	local CurrentDiscordInvite = isfile('Invite.hex') and readfile('Invite.hex') or nil
	local Code = "ao29e9"
	if Request then
		local Invite
		local r = Request(
			{
				['Method'] = 'GET',
				['Headers'] = {
					['discordLinkRequest'] = "true"
				},
				['Url'] = 'https://raw.githubusercontent.com/MrolivesGaming/HexHub/main/Discord_Invite.txt'
			})
		if r.StatusCode ~= 200 or not r.Successful then
			Invite = Code
		else
			Invite = r.Body
		end
		if not CurrentDiscordInvite or CurrentDiscordInvite ~= Invite then
			Request(
				{
					['Method'] = 'POST',
					['Headers'] = {
						["origin"] = 'https://discord.com',
						["Content-Type"] = "application/json"
					},
					['Url'] = 'http://127.0.0.1:6463/rpc?v=1',
					['Body'] = game:GetService('HttpService'):JSONEncode({cmd="INVITE_BROWSER",args={code=Invite},nonce=game:GetService('HttpService'):GenerateGUID(false):lower()})
				}    
			)
			writefile('Invite.hex',Invite)
		end
	else
		setclipboard("discord.gg/"..Code)
	end	
end

return hexhelper
