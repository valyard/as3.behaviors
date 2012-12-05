////////////////////////////////////////////////////////////////////////////////
//
//  © 2007 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.core {

	/**
	 * @author					BlooDHounD
	 */
	public function parseBoolean(s:String):Boolean {
		if ( !s ) return false;
		s = s.toLowerCase();
		return s && !(
			s == 'false' ||
			s == 'nan' ||
			s == 'no' ||
			parseFloat(s) == 0
		)
	}

}