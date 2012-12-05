////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Valentin Simonov
//
////////////////////////////////////////////////////////////////////////////////
package ru.valyard.behaviors {
	import by.blooddy.core.meta.TypeInfo;
	import by.blooddy.core.utils.WeakRef;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import ru.valyard.behaviors.events.BehaviorCollectionEvent;
	
	/**
	 * Collection of behaviors attached to an object.
	 * @author	Valentin Simonov
	 */
	public final class BehaviorCollection extends EventDispatcher {
		
		/**
		 * @param target	Target of this collection.
		 */
		public function BehaviorCollection(target:Object) {
			this._target = new WeakRef(target);
		}
		
		//--------------------------------------------------------------------------
		//
		// Private variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private const _behaviors:Array = new Array();
		
		/**
		 * @private
		 */
		private const _HASH:Object = new Object();
		
		/**
		 * @private
		 */
		private var _target:WeakRef;
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Vector of all behaviors attached
		 */ 
		public function get all():Array {
			return this._behaviors.concat();
		}
		
		/**
		 * Total number of behaviors
		 */ 
		public function get length():uint {
			return this._behaviors.length;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Checks if target has behavior attached. Can specify a class, an interface or
		 * an instance of some behavior (extending Behavior).
		 * @param value		Class, interface or instance of behavior
		 * @return			true/false
		 */
		public function has(value:Object):Boolean {
			var isClass:Boolean = value is Class;
			var className:String = getQualifiedClassName(value);
			var behaviors:Array = this._HASH[className];
			if (!behaviors || behaviors.length == 0) return false;
			if (!isClass && behaviors.indexOf(value) == -1) return false;
			
			return true;
		}
		
		/**
		 * Removes behavior from target. Can specify a class, an interface or
		 * an instance of some behavior (extending Behavior).
		 * @param value		Class, interface or instance of behavior
		 * @param force		Force removal
		 * @return			True if behavior was removed
		 */
		public function remove(value:Object, force:Boolean = false):Boolean {
			var isClass:Boolean = value is Class;
			var className:String = getQualifiedClassName(value);
			
			if (isClass) {
				var behaviors:Array = this._HASH[className];
				if (!behaviors || behaviors.length == 0) return false;
				var oldBehaviors:Array = behaviors.concat();
				var result:Boolean = true;
				for each (var behavior:Behavior in behaviors) result &&= remove(behavior, force);
				return result;
			} else {
				if (!(value is Behavior)) return false;
				behavior = value as Behavior;
				if (!behavior.$detach() && !force) {
					return false;
				} else {
					index = _behaviors.indexOf(behavior);
					_behaviors.splice(index, 1);
					
					var names:Array = getClassNames(value, className);
					var l:uint = names.length;
					for (var i:uint = 0; i < l; i++) {
						var name:String = names[i];
						behaviors = _HASH[name];
						if (!behaviors) continue;
						var index:int = behaviors.indexOf(behavior);
						behaviors.splice(index, 1);
					}
					
					behavior.$remove();
					dispatchEvent(new BehaviorCollectionEvent(BehaviorCollectionEvent.BEHAVIOR_REMOVED, false, true, behavior));
					return true;
				}
			}
		}
		
		/**
		 * Removes all behaviors.
		 * @param force		Force removal
		 * @return			True if all behaviors were removed
		 */
		public function removeAll(force:Boolean = false):Boolean {
			if (!this._behaviors.length) return false;
			
			var copy:Array = this._behaviors.concat();
			var l:uint = copy.length;
			var removed:Boolean = true;
			for (var i:uint; i < l; i++) {
				var result:Boolean = this.remove( copy[i], force );
				removed &&= result;
			}
			return removed;
		}
		
		/**
		 * Retrieves behavior of given class or interface
		 * @param value		Class or interface.
		 * @return			Behavior of provided class or null.
		 */ 
		public function get(value:Class):Behavior {
			var className:String = getQualifiedClassName(value);
			var behaviors:Array = this._HASH[className];
			if (!behaviors || behaviors.length == 0) return null;
			
			return behaviors[0];
		}
		
		/**
		 * Retrieves all behaviors of given class or interface
		 * @param value		Class or interface.
		 * @return			Behavior of provided class or null.
		 */ 
		public function getAll(value:Class):Array {
			var className:String = getQualifiedClassName(value);
			var behaviors:Array = this._HASH[className];
			if (!behaviors) return [];
			
			return behaviors.concat();
		}
		
		//--------------------------------------------------------------------------
		//
		// Overriden methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Private functions
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function getClassNames(value:Object, selfName:String):Array {
			var type:TypeInfo = TypeInfo.getInfo(value);
			var names:Array = [selfName];
			
			var superClasses:Vector.<QName> = type.getSuperclasses();
			var l:uint = superClasses.length-3; // Behavior, EventDispatcher, Object
			for (var i:uint = 0; i < l; i++) {
				names.push(superClasses[i].toString());
			}
			
			var interfaces:Vector.<QName> = type.getInterfaces();
			l = interfaces.length-1; // IEventDispatcher
			for (i = 0; i < l; i++) {
				names.push(interfaces[i].toString());
			}
			
			return names;
		}
		
		/**
		 * @private
		 */
		internal final function $add(behavior:Behavior):Boolean {
			if (_target.get() == undefined) return false;
			
			var className:String = getQualifiedClassName(behavior);
			var behaviors:Array = _HASH[className];
			if (behaviors && behaviors.indexOf(behavior) > -1) return false;
			
			var names:Array = getClassNames(behavior, className);
			
			var l:uint = names.length;
			for (var i:uint = 0; i < l; i++) {
				var name:String = names[i];
				behaviors = _HASH[name];
				if (!behaviors) {
					behaviors = [];
					_HASH[name] = behaviors;
				}
				behaviors.push(behavior);
			}
			
			this._behaviors.push( behavior );
			
			super.dispatchEvent( new BehaviorCollectionEvent(BehaviorCollectionEvent.BEHAVIOR_ADDED, false, true, behavior) );
			return true;
		}
		
		//--------------------------------------------------------------------------
		//
		// Event handlers
		//
		//--------------------------------------------------------------------------
		
	}
}