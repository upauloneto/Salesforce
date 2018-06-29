public Integer random(Integer x, Integer y){
    return Integer.valueof(Math.floor(Math.random() * ((y-x)+1) + x));
}

Map<Integer,String> users = new Map<Integer,String>();

		List<User> us = [Select id, Name, Title from User where IsActive = true and UserRole.Name = 'Vendedor CE'];
		
		for(Integer i = 0 ; i < us.size(); i++){
			users.put(i, us[i].id);
		}

system.debug(users);

List<Opportunity> optoinsert = new List<Opportunity>();

for(Integer i = 0 ; i < 100; i++){
    Opportunity opp = new Opportunity();
    opp.NAme = 'Teste - ' + String.valueOf(i);
    opp.Accountid = '001q000000nDUq9'; // Id de uma conta
    opp.Amount = 5444;
    opp.Ownerid = users.get( random( 0 ,us.size()-1) );
    opp.Valor_Custo__c = 100;
    opp.Percentual__c = 2;
    opp.CloseDate = system.today();
    opp.StageName = 'Fechado e ganho';
    optoinsert.add(opp);
}
insert optoinsert;