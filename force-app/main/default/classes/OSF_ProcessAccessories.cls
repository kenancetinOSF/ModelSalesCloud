public class OSF_ProcessAccessories {
    @InvocableMethod(label='Process Accessories' description='Creates accessory records and relates them to inquiry records')
    public static void createAccessories(List<AccessoryWrapper> accessoryWrappers) {
        List<Accessory__c> accessoriesToCreate = new List<Accessory__c>();
        
        // Iterate over each accessory wrapper
        for (AccessoryWrapper accessoryWrapper : accessoryWrappers) {
            // Get the inquiry position collection for the current accessory wrapper
            List<Inquiry__c> positions = accessoryWrapper.positionsCollection;
            
            // Iterate over each position in the inquiry position collection
            for (Inquiry__c position : positions) {
                // Create a new accessory record and set the relationship to the inquiry record
                Accessory__c accessory = new Accessory__c();
                accessory.Name = accessoryWrapper.accessoryName;
                accessory.Inquiry__c = position.Id;
                
                accessoriesToCreate.add(accessory);
            }
        }
        
        // Insert the accessory records
        insert accessoriesToCreate;
    }
    
    // Wrapper class to hold the input variables from the flow
    public class AccessoryWrapper {
        @InvocableVariable(label='Inquiry Position Collection' description='collection of Inquiry records')
        public List<Inquiry__c> positionsCollection;
        
        @InvocableVariable(label='Accessory Collection' description='Collection of accessory inputs')
        public List<String> accessoryCollection;
        
        // Helper method to convert the accessoryCollection into a list of Accessory__c records
        public List<Accessory__c> getAccessoryRecords() {
            List<Accessory__c> accessoryRecords = new List<Accessory__c>();
            
            for (String accessoryName : accessoryCollection) {
                Accessory__c accessory = new Accessory__c();
                accessory.Name = accessoryName;
                
                accessoryRecords.add(accessory);
            }
            
            return accessoryRecords;
        }
    }
}