
## Brief introduction:

The project is the objective-c version of solution for problem “Merchant's Guide To The Galaxy”.

## Structure:

* Controllers 
    ViewController: deal with input output data

* Models 	 
    1. GGTranslation 
        * translation input
		* use regex expression to check input type and deal with it
		* use singleton to share the processed result

	2. GGRomanArabicConversion: convert between roman number and arabic number
		* convert roman number to arabic number based on rules like repeat, subtract
		* convert arabic number to roman number

* GuideToTheGalaxyTests: unit tests
		* tested roman/arabic unit conversion
		* tested translation input and output



