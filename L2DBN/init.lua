local _PACKAGE = string.gsub(..., "%.", "/") or ""
if string.len(_PACKAGE) > 0 then _PACKAGE = _PACKAGE .. "/" end

local Class        = require(_PACKAGE .. 'Class');
local SceneManager = require(_PACKAGE .. 'SceneManager');
local SaveManager  = require(_PACKAGE .. 'SaveManager');
local Scene        = require(_PACKAGE .. 'Scene');
local StateMachine = require(_PACKAGE .. 'StateMachine');
local Rect         = require(_PACKAGE .. 'Rect');
local Bounds       = require(_PACKAGE .. 'Bounds');
local Button       = require(_PACKAGE .. 'Button');
local SubScene     = require(_PACKAGE .. 'SubScene');
local CombatTile   = require(_PACKAGE .. 'CombatTile');
local CombatMap    = require(_PACKAGE .. 'CombatMap');
local CombatActor  = require(_PACKAGE .. 'CombatActor');
local table        = require(_PACKAGE .. 'table');
local push         = require(_PACKAGE .. 'push');
local bind         = require(_PACKAGE .. 'bind');
local image        = require(_PACKAGE .. 'image');

return {
    Class        = Class,
    SceneManager = SceneManager,
    SaveManager  = SaveManager,
    Scene        = Scene,
    Rect         = Rect,
    Bounds       = Bounds,
    SubScene     = SubScene,
    Button       = Button,
    combat       = {
        Tile = CombatTile,
        Map = CombatMap,
        Actor = CombatActor

    },
    table        = table,
    push         = push,
    bind         = bind,
    image        = image,
    StateMachine = StateMachine
};
