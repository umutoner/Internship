global class CampaignUpdateScheduler implements Schedulable {
    global void execute (SchedulableContext sc) {
        CampaignUpdateBatch b = new CampaignUpdateBatch(); 
       database.executebatch(b, 200);
    }
}