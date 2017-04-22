package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.CharSpecial;
	import classes.CoC;
	import classes.Player;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.helper.StageLocator;
	import classes.CharCreation;
	import classes.GlobalFlags.kFLAGS;
	
    public class CharCreationTest {
        private var cut:CharCreationForTest;
		private var player:Player;
		
		[BeforeClass]
		public static function runOnceForTestClass():void { 
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
        [Before]
        public function setUp():void {
			cut = new CharCreationForTest();
			this.player = new Player();
			kGAMECLASS.player = player;
			kGAMECLASS.flags = new DefaultDict();
        }  
     
		[Test(description="Check that the array or vector for vaginas is correctly initialised")] 
        public function testReincarnateCreatesVaginaStoreNotNull():void {
			cut.testReincarnate();
			
			assertThat(kGAMECLASS.player.vaginas, notNullValue());
        }
		
		[Test(description="Check that the array or vector for vaginas is correctly initialised")] 
        public function testReincarnateCreatesVaginaStoreZeroLength():void {
			cut.testReincarnate();
			
			assertThat(kGAMECLASS.player.vaginas, emptyArray());
        }
		
		[Test] 
        public function newGameGo_clitLengthIsResetWhenNotNewGamePlus():void {
			player.clitLength = 3;
			
			cut.newGameGo();
			
			assertThat(kGAMECLASS.player.clitLength, equalTo(0));
        }
		
		[Test(description="New game plus reduces the clit length to a maximum if it is too long")] 
        public function newGameGo_clitLengthIsResetToMaxWhenNewGamePlus():void {
			player.clitLength = 3;
			kGAMECLASS.flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = 1;
			
			cut.newGameGo();
			
			assertThat(kGAMECLASS.player.clitLength, equalTo(CharCreation.NEW_GAME_PLUS_RESET_CLIT_LENGTH_MAX));
        }
		
				
		[Test(description="New game plus will not change the clit length if it is below the maximum")] 
        public function newGameGo_clitLengthIsNotResetWhenNewGamePlus():void {
			var testLength : Number = 1.2;
			player.clitLength = testLength;
			kGAMECLASS.flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = 1;
			
			cut.newGameGo();
			
			assertThat(kGAMECLASS.player.clitLength, equalTo(testLength));
        }
		
		[Test]
		public function isAWoman_checkClitLength():void {
			cut.isAWoman();
			
			assertThat(player.vaginas[0].clitLength, equalTo(VaginaClass.DEFAULT_CLIT_LENGTH));
		}
		
		[Test]
		public function isAHerm_checkClitLength():void {
			cut.isAHerm();
			
			assertThat(player.vaginas[0].clitLength, equalTo(VaginaClass.DEFAULT_CLIT_LENGTH));
		}
    }
}

import classes.CharCreation;
/**
 * This is to allow the testing of functions without making them public in the actual class.
 */
class CharCreationForTest extends CharCreation {
	public function testReincarnate():void {
		reincarnate();
	}
}
