////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Valentin Simonov
//
////////////////////////////////////////////////////////////////////////////////
package ru.valyard.behaviors {
	
	/**
	 * Shortcut for retrieving object's behaviors.
	 * @param target	Object to get behaviors for.
	 * @return			An instance of BehaviorsCollection for this object.
	 * @author	Valentin Simonov
	 */
	public function behaviors(target:Object):BehaviorCollection {
		return BehaviorManager.getBehaviors(target);
	}
	
}