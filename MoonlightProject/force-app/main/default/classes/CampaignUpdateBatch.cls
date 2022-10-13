public class CampaignUpdateBatch implements Database.Batchable<sObject> {
     
    public Database.QueryLocator start(Database.BatchableContext BC){
        String query= 'SELECT Status FROM Campaign WHERE EndDate=YESTERDAY';
        return Database.getQueryLocator(query);
    }
 
    public void execute(Database.BatchableContext BC, List<Campaign> campaignList){
       try {
        for (Campaign eachCampaign : campaignList) {
            eachCampaign.Status = 'Expired';
        }
        update campaignList;

       } catch (Exception e) {
        system.debug(e.getMessage());
       }
       
    }
 
    public void finish(Database.BatchableContext BC){
        system.debug('Batch class is completed');

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List <User> users = [SELECT Id, Email FROM User WHERE Id IN (SELECT UserOrGroupId FROM GroupMember WHERE Group.Name ='BatchGroup')];
            List<String> toAddresses = New List<String>();
            for (user eachUser : users) {
                toAddresses.add(eachUser.email);
            }
            mail.setToAddresses(toAddresses);
            mail.setSubject('Campaign Update Batch Completed');
            mail.setPlainTextBody ('Updated records successfully worked with batch apex');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
    }
 }