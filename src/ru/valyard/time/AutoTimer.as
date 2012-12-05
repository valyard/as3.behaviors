////////////////////////////////////////////////////////////////////////////////
//
//  © 2010 Valentin Simonov
//
////////////////////////////////////////////////////////////////////////////////
package ru.valyard.time
{
	import flash.errors.IllegalOperationError;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Timer which has fixed delay and starts automatically when an event listener is added.
	 * @author	Valentin Simonov
	 */
	public class AutoTimer extends Timer
	{
		public function AutoTimer(delay:Number)	{
			super( delay );
		}
		
		//--------------------------------------------------------------------------
		//
		// Private variables
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Overriden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public override function set delay(value:Number):void {
			throw new IllegalOperationError();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set repeatCount(value:int):void {
			throw new IllegalOperationError();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function start():void {
			throw new IllegalOperationError();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function stop():void {
			throw new IllegalOperationError();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function reset():void {
			throw new IllegalOperationError();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
			super.addEventListener( type, listener, useCapture, priority, useWeakReference );
			if ( type == TimerEvent.TIMER ) {
				if ( !super.running ) {
					super.start();
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public override function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			super.removeEventListener( type, listener, useCapture );
			if ( type == TimerEvent.TIMER ) {
				if ( super.running && !super.hasEventListener( type ) ) {
					super.stop();
				}
			}
		}
		
		//--------------------------------------------------------------------------
		//
		// Private functions
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Event handlers
		//
		//--------------------------------------------------------------------------
		
	}
}