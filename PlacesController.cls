global with sharing class PlacesController {

	global List<Lead> getLeads{	get; set; }

	global PlacesController(){
		getLeads = [Select id,Google_place_id__c from Lead where LeadSource='Google Place'];
	}

	@RemoteAction
    public static String CreateLeads( List<String> leads) {

    	/* Método para criação de Leads */

        try{
        	
        	List<Lead> leadsToInsert = new List<Lead>();

        	for(String json : leads){

        		/* Replace para varíavel interna */
        		json = json.replace('"time"','"time_x"');

        		Lead lead = new Lead();

        		Place_Json place = Place_Json.parse(json);

        		lead.Company = place.name;
        		lead.LeadSource = 'Google Place';

        		Location location = Location.newInstance(
        			place.Geometry.location.lat, 
        			place.Geometry.location.lng
        		);


        		Map<String,String> address = new Map<String,String>();
        		for(Place_Json.Address_components adr : place.address_components){
        			address.put(adr.types[0],adr.short_name);
        		}


        		lead.Street	 = address.get('route')+ ', '+ address.get('street_number') + ' - ' + address.get('sublocality_level_1');
        		lead.City = address.get('administrative_area_level_2');
        		lead.State = address.get('administrative_area_level_1');
        		lead.Country = address.get('country');
        		lead.PostalCode  = address.get('postal_code');

        		lead.Phone = place.formatted_phone_number;

        		if(place.name.length() > 79)
        			lead.LastName = place.name.substring(0,79);
        		else
        			lead.LastName = place.name;
        		
        		
        		lead.Endere_o__latitude__s   = location.getLongitude();
        		lead.Endere_o__longitude__s   = location.getLatitude();
        		lead.Website = place.website;

        		lead.Google_place_id__c = place.place_id;
        		lead.Avalia_o__c = place.rating;

        		lead.Data_opening__c = json;
        		lead.Data_review__c = json;

        		leadsToInsert.add(lead);
        	}


        	insert(leadsToInsert);

        	return leadsToInsert.size() > 0 ? String.valueof(leadsToInsert.size()) + ' Leads criados com sucesso' : 'Tente novamente!';
        }catch(Exception e){
        	return 'Erro ao criar Leads' + e.getMessage();
        }

    }

}