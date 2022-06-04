import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.EntityJoinWorldEvent;
import crafttweaker.api.event.living.LivingUpdateEvent;
import crafttweaker.api.entity.Entity;
import crafttweaker.api.util.math.BlockPos;
smithing.addRecipe("gold_upgraded_netherite_shield", <item:upgradednetherite:gold_upgraded_netherite_shield>, <item:bettershields:netherite_shield>, <item:upgradednetherite:gold_upgraded_netherite_ingot>);
smithing.addRecipe("phantom_upgraded_netherite_shield", <item:upgradednetherite:phantom_upgraded_netherite_shield>, <item:bettershields:netherite_shield>, <item:upgradednetherite:phantom_upgraded_netherite_ingot>);
smithing.addRecipe("fire_upgraded_netherite_shield", <item:upgradednetherite:fire_upgraded_netherite_shield>, <item:bettershields:netherite_shield>, <item:upgradednetherite:fire_upgraded_netherite_ingot>);
smithing.addRecipe("ender_upgraded_netherite_shield", <item:upgradednetherite:ender_upgraded_netherite_shield>, <item:bettershields:netherite_shield>, <item:upgradednetherite:ender_upgraded_netherite_ingot>);
smithing.addRecipe("water_upgraded_netherite_shield", <item:upgradednetherite:water_upgraded_netherite_shield>, <item:bettershields:netherite_shield>, <item:upgradednetherite:water_upgraded_netherite_ingot>);
smithing.addRecipe("wither_upgraded_netherite_shield", <item:upgradednetherite:wither_upgraded_netherite_shield>, <item:bettershields:netherite_shield>, <item:upgradednetherite:wither_upgraded_netherite_ingot>);
smithing.addRecipe("poison_upgraded_netherite_shield", <item:upgradednetherite:poison_upgraded_netherite_shield>, <item:bettershields:netherite_shield>, <item:upgradednetherite:poison_upgraded_netherite_ingot>);
craftingTable.remove(<item:village_employment:orb_of_dominance>);
craftingTable.remove(<item:village_employment:orb_of_dominance_staff>);
craftingTable.remove(<item:village_employment:iron_golem_helmet>);
craftingTable.remove(<item:village_employment:iron_golem_chestplate>);
craftingTable.remove(<item:village_employment:iron_golem_leggings>);
craftingTable.remove(<item:village_employment:iron_golem_boots>);
// Every time an Entity "joins" (spawns) the World...
CTEventManager.register<crafttweaker.api.event.entity.EntityJoinWorldEvent>((event) => {
	val level = event.world;
	var range = 64;
	var nospawnNumber = 20 as usize;
	var cullingNumber = 25 as usize;
	// If it's an Ant...
	if event.entity.getType() == <entitytype:alexsmobs:leafcutter_ant> {
		var pos1 = new BlockPos(event.entity.blockX-range, event.entity.blockY-range, event.entity.blockZ-range);
		var pos2 = new BlockPos(event.entity.blockX+range, event.entity.blockY+range, event.entity.blockZ+range);
		// Get all Ants in the 64 block range...
		var ents = level.getEntities(event.entity, pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, e => e.getType() == <entitytype:alexsmobs:leafcutter_ant>);
		// if there are more than 20...
		if(ents.length > nospawnNumber){
			// don't allow it to "join"
			event.cancel();
		}
		// if there are more than 25...
		if(ents.length > cullingNumber){
			// kill them all
			for ent in ents {
				ent.kill();
			}
		}
	}
});