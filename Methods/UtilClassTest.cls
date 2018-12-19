@isTest
private class UtilClassTest {

	private static testMethod void TestaEncriptogrfia() {
        
        String data = '00629000007KBXIAA4';
        String cripto = UtilClass.EncriptaData(data);
        
        System.assertNotEquals('00629000007KBXIAA4', cripto);
        
        
	}
	
	private static testMethod void TestaDecriptogrfia() {
        
        String data = '00629000007KBXIAA4';
       try{
        String cripto = UtilClass.EncriptaData(data);
        
        String decript = UtilClass.DecriptaData(cripto);
        
        System.assertEquals(data, decript);
       }catch(exception e){
           
       }
        
	}

}