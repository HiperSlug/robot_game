# Disposable

**Disposable** is a real-time top-down pvp game where players attack eachother by building dynamic robots from moduluar components.


- **Modulur Robot Assembly**
- **Economy & Information Warfare**
- **Online PvP and Combat**



# Planning


## Core gameplay loop
- Create specialized robots to gather resources, attack, and for recon.
- Utilize robot communication to have advanced behavior.
- Win encounters to gain an economic advantage and eventually destroy the enemies tower.

## MVP
The MVP will allow the players to build specialized robots that can fight eachother in a online arena. 

## Features
Optional features will not be included in the MVP

- [ ] Online (optional)
	- [ ] Online hosted P2P. using UPNP? No anti-cheat, just syncing states. (just start with local P2P)
	- [ ] Basic profiles
		- [ ] Name
		- [ ] PFP (optional)
	- [ ] Match finder through some free server hosting
		- [ ] Optional password protection
	- [ ] Match finder GUI
		- [ ] Create match button
			- [ ] Sends match finder name, optional password, and IP.
			- [ ] Choose arena, rand or specific (optional)
		- [ ] Display a list of buttons, each with a name and a icon representing weather you need a password
- [ ] Arena
	- [x] A pre-build tilemap with tower locations
	- [x] Start with just one arena
	- [ ] Fog of war (Optional)
- [ ] Matches 
	- [ ] Randomly choosing sides
	- [ ] Option to forfeit. (optional)
	- [ ] Option to leave game, after match having ended.
	- [ ] Match end when main tower looses all hp
	- [ ] Match end timer that causes the player with the least damage to main tower victory (optional)
		- [ ] Coin flip on tie
	- [ ] Match end Display (optional)
	- [ ] Match start countdown (optional)
- [ ] Robots
	- [ ] Creating robots
		- [ ] MVP:
			- [ ] Prebuilt loadouts
				- [x] Right click in a valid area to open gui
				- [x] Select Loadout
		- [ ] More Indepth (optional)
			- [ ] Right click in a valid area around your main tower to start creating a robot
			- [ ] Blueprints (optional)
				- [ ] Fully componented robots can be created from a hotbar
			- [ ] Component Selection GUI
				- [ ] Packages: Multiple components that can be used together (optional)
					- [ ] Built in
						- [ ] Things that require camera + Cam
						- [ ] Comm emittor + thing it's communicating
					- [ ] Custom (optional)
						- [ ] A plus button that opens another gui to select all components in a new package
				- [ ] Categories
					- [ ] Each category will have a title and multiple components
					- [ ] Each component will have a cost, it's name, and then +/- buttons that allow you to add more or less.
			- [ ] Preview:
				- [ ] Randomly generated name
				- [ ] Visual preview
				- [ ] Component list
			- [ ] Placing:
				- [ ] Upon clicking done the robot will be created:
					- [ ] All components with variables such as Nav, CamCtrl, WpnCtrl will create interactable ways to set their variables
	- [ ] Components
		- [ ] Weapon
			- [x] Laser: Deal constant damage in facing direction, limited range, no pierce.
			- [ ] MORE TODO. These shouldnt be that complicated, whatever I add should just be different ways of having hitboxes act.
		- [x] Engine (aka speed)
		- [x] Health
		- [x] Pathfind towards closest enemy component (PTCEC?)
		- [ ] Not MVP:
			- [ ] Camera
				- [ ] Shapes
					- [ ] Cone: TAU / 4, double radius
					- [ ] Half Circle: TAU / 2, sqrt(2) radius
					- [ ] Full circle: TAU, base radius
				- [ ] Radius: Linearly increasing stat component.
			- [ ] WeaponControl // FOR ALL 3 CONTROL COMPONENTS, MULTIPLE DIFFERENT ACTIONS SHOULD BE ADDITIVE
				- [ ] Default (none other selected): Weapon points towards movement direction / Forward
				- [ ] Direction: Weapon points in a selected direction
				- [ ] Targeting: When paired with camera, points towards enemies in viewcone.
			- [ ] Navigation (only works with at least 1 engine) // FOR ALL 3 CONTROL COMPONENTS, MULTIPLE DIFFERENT ACTIONS SHOULD BE ADDITIVE
				- [ ] Default (none other selected): No movement
				- [ ] Direction: Movement in straight line
				- [ ] Pathfinding: When paired with camera, pathfinds towards a point using only the collision in the camerae
					- [ ] Custom pathfinding that can handled obstascles like walls
			- [ ] CameraControl // FOR ALL 3 CONTROL COMPONENTS, MULTIPLE DIFFERENT ACTIONS SHOULD BE ADDITIVE
				- [ ] Default (none other selected): Point towards movement direction / Forward
				- [ ] Velocity: Rotates at a constant angular velocity
				- [ ] Sinosoidal: Rotates at a angular velocity proportional to a sinosoidal function.
			- [ ] Communication
				- [ ] Nav Emittor/Receiver: overrides, or adds receivers Nav components
				- [ ] WpnCtrl Emittor/Receiver: overrides, or adds receivers WpnCtrl component
				- [ ] Cam Emittor/Receiver: overrides, or adds receivers Cam component
				- [ ] Sound Emittor/Receiver (optional): overrides, or adds receivers Audio component
				- [ ] Server Emittor: Allow YOU to see sensor data (cam and audio (optional))
				- [ ] Server Receiver: Allow YOU to modify Nav and WpnCtrl components on the fly, including a manual override with wasd and mouse.
					- [ ] On a selected robot icons will appear under it for modifiable settings such as Nav, Wpn, etc.
						- [ ] The components must handle creating the modification GUI and telling the receiver of their ability to be modified.
					- [ ] Need to be able to start and end a modification/override:
						- [ ] HUD element that lets you access robots by name
							- [ ] Procedurally Generated Names
						- [ ] Ability to select robots with LMB without it clasing with another control // TODO: Other Controls
		- [x] Backend
			- [x] Hurtbox component
- [ ] Economy (optional)
	- [ ] ¯\_(ツ)/¯
	- [ ] My current thoughts on econ would put this game way out of scope
