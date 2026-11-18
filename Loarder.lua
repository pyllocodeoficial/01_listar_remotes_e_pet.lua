-- 01: Lista todos os RemoteEvent/RemoteFunction do ReplicatedStorage,
-- os itens do Player e os atributos do primeiro "pet" encontrado.
-- Mostra o resultado numa caixa na tela (copiavel) e no console.

local RS = game:GetService("ReplicatedStorage")
local player = game:GetService("Players").LocalPlayer

task.wait(3) -- espera o jogo carregar

local lines = {}
local function add(s) table.insert(lines, s) end

add("=== REMOTES (ReplicatedStorage) ===")
for _, v in ipairs(RS:GetDescendants()) do
	if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
		add(v.ClassName .. " | " .. v:GetFullName())
	end
end

add("")
add("=== ITENS DO PLAYER ===")
for _, v in ipairs(player:GetChildren()) do
	add(v.ClassName .. " | " .. v.Name .. " | " .. #v:GetChildren() .. " filhos")
end

add("")
add("=== PRIMEIRO PET ENCONTRADO ===")
for _, f in ipairs(player:GetChildren()) do
	local pet = f:GetChildren()[1]
	if pet and not f:IsA("PlayerGui") and not f:IsA("Backpack") then
		add("Pasta: " .. f.Name .. " | Pet: " .. pet.Name)
		for k, val in pairs(pet:GetAttributes()) do
			add("  attr " .. k .. " = " .. tostring(val))
		end
		for _, c in ipairs(pet:GetChildren()) do
			add("  filho " .. c.ClassName .. " | " .. c.Name)
		end
		break
	end
end

local text = table.concat(lines, "\n")
print(text)

local gui = Instance.new("ScreenGui")
gui.Name = "ListaRemotes"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local box = Instance.new("TextBox")
box.Size = UDim2.new(0, 320, 0, 220)
box.Position = UDim2.new(0.5, -160, 0.5, -110)
box.BackgroundColor3 = Color3.new(0, 0, 0)
box.BackgroundTransparency = 0.2
box.TextColor3 = Color3.new(1, 1, 1)
box.Font = Enum.Font.Code
box.TextSize = 12
box.TextXAlignment = Enum.TextXAlignment.Left
box.TextYAlignment = Enum.TextYAlignment.Top
box.TextWrapped = true
box.MultiLine = true
box.ClearTextOnFocus = false
box.Text = text
box.Parent = gui

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 60, 0, 22)
close.Position = UDim2.new(0.5, 100, 0.5, -136)
close.Text = "Fechar"
close.BackgroundColor3 = Color3.fromRGB(190, 55, 55)
close.TextColor3 = Color3.new(1, 1, 1)
close.Parent = gui
close.Activated:Connect(function() gui:Destroy() end)
