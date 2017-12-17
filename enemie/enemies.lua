require "enemie/enemie_human"
require "enemie/enemie_dog"
require "enemie/enemie_marfian"
require "enemie/enemie_cat"

enemies = {}
enemies.list = {}

function enemies.load()
  
  enemie_human.load()
  enemie_dog.load()
  enemie_marfian.load()
  enemie_cat.load()
  
  enemies.reset()
end

function enemies.reset()
  enemies.list = {}
  enemie_human.list = {}
  enemie_dog.list = {}
  enemie_marfian.list = {}
  enemie_cat.list = {}
end

function enemies.update_enemie_list()
  enemies.list = {enemie_human, enemie_dog, enemie_marfian, enemie_cat}
end

function enemies.update(dt)

  for i_enemie, v_enemie in ipairs(enemies.list) do
    v_enemie.update(dt)
    for i, v in ipairs(v_enemie.list) do
      mapManager.handleContact(dt,v)
    end
  end
end



function enemies.draw()
  for i_enemie, v_enemie in ipairs(enemies.list) do
    v_enemie.draw()
  end
end



function joinTables(t1, t2)

   for k,v in ipairs(t2) do
      table.insert(t1, v)
   end

   return t1
end

function tableMerge(t1, t2)
    for k,v in ipairs(t2) do
    	if type(v) == "table" then
    		if type(t1[k] or false) == "table" then
    			tableMerge(t1[k] or {}, t2[k] or {})
    		else
    			t1[k] = v
    		end
    	else
    		t1[k] = v
    	end
    end
    return t1
end
