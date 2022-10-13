@isTest
private with sharing class CampaignUpdateBatchTest {
@TestSetup

     public static void testCampaignData() {
        List<Campaign> listCam= new List<Campaign>();
       for (Integer i = 0; i < 100; i++) {
        Campaign cm= new Campaign(); 
        cm.EndDate= Date.today()-1;
        cm.Status = 'Active';
        cm.name= 'Test' +i;
        listCam.add(cm);
        
       }
       for (Integer i = 0; i < 100; i++) {
        Campaign cm= new Campaign(); 
        cm.EndDate= Date.today()+10;
        cm.Status = 'Active'
        cm.name= 'Test1' +i;
        listCam.add(cm);      

    }
    insert listCam;
  
}

@isTest
  private static void testBatch() {
    test.startTest();
    CampaignUpdateBatch cub= new CampaignUpdateBatch();
    Database.executeBatch(cub);
    test.stopTest();

    system.assertEquals(200, [Select COUNT() FROM Campaign where Status=:'Expired']);
    
  }  
}