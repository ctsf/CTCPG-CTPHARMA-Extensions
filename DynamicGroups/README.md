# Extension for Dynamic Groups
Full user guide for [CT CPG](https://help.customertimes.com/articles/ct-cpg-publication/cpg-groups-management)
and for [CT Pharma](https://github.com/ctsf/CTCPG-CTPHARMA-Extensions/tree/CTOM-1742/DynamicGroups)

This extension may be applied with **CT CPG package (since V1.40)** and **CT Pharma package (since V2.38)**

## Notice
The following objects are supported out of the box and cannot be used with this extension:
- Account
- Contact
- User
- CTCPG__Product__c
- CTPHARMA__Product__c  

This extension does not support  External or Big Objects.

## Guidelines
Follow the steps below to enable 'Dynamic Groups' for any Standard or Custom object:
- Add the API name of the Object you want to support in the picklist `CTCPG__ObjectType__c`(`CTPHARMA__ObjectType__c`) field 
  of the `CTCPG__Group__c`(`CTPHARMA__Group__c`) object. 
  **NOTE**: _picklist value MUST be an API name with namespace prefix(if any) and postfix(if any), you may set any label for this picklist value_


- Create a lookup field to this object in the `CTCPG__GroupMember__c`(`CTPHARMA__GroupMember__c`) object.
  **NOTE**: _There must be only one lookup field for one object. The random field will be used if `CTCPG__GroupMember__c`(`CTPHARMA__GroupMember__c`) object contains more than one lookup field for one object._


- Copy [Source](source) code locally and replace commented lines in [Trigger](source/triggers/DynamicGroupExtensionProcess.trigger) and 
  [Test Class](source/classes/Test_DynamicGroupExtension.cls) with your data. 
  Also, you may rename [Trigger](source/triggers/DynamicGroupExtensionProcess.trigger) and
  [Test Class](source/classes/Test_DynamicGroupExtension.cls) to match your naming convention.


- Deploy the changed [Source](source) code in your org using your IDE, 
  [Workbench](https://workbench.developerforce.com/metadataDeploy.php), 
  [SFDX](https://developer.salesforce.com/tools/sfdxcli), or any other tool.
