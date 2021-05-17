/*******************************************************************************
 * Copyright Copyright(C) 2007-2021 Customertimes Corp.
 * Columbus Circle, 15th Floor, #1513
 * New York, NY 10019
 * mailto:support@customertimes.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
 * THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 * OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

@isTest
public with sharing class Test_DynamicGroupExtension {

    /** SETUP THIS */
    private static final String ctPackage = ''; // CTCPG or CTPHARMA
    private static final String objectName = ''; // Your object API name
    /** FINISH SETUP */

    // Test variables
    private static final String targetName = 'Test Name';

    private static String getName(String name) {
        return ctPackage + '__' + name;
    }

    @TestSetup static void setup() {

        SObject dynamicGroup = Schema.getGlobalDescribe().get(getName('Group__c')).newSObject();
        dynamicGroup.put(getName('ObjectType__c'), objectName);
        dynamicGroup.put(getName('IsDynamic__c'), true);
        dynamicGroup.put(getName('GroupFilter__c'), 'Name Like \'%' + targetName + '%\'');
        dynamicGroup.put(getName('FieldList__c'), 'Name');
        insert dynamicGroup;
    }

    @IsTest static void testInsert() {

        SObject currentObject = Schema.getGlobalDescribe().get(objectName).newSObject();
        currentObject.put('Name', targetName);

        Test.startTest();
        //Checking how the trigger works when inserting a record
        insert currentObject;

        Test.stopTest();
    }

    @IsTest static void testUpdate() {

        SObject currentObject = Schema.getGlobalDescribe().get(objectName).newSObject();
        currentObject.put('Name', targetName);

        Test.startTest();
        //Checking how the trigger works when inserting a record
        insert currentObject;

        //We check the trigger when updating the record, dynamic groups should not work in this case
        currentObject.Name = 'testMark2';
        update currentObject;
        Test.stopTest();
    }

    @IsTest static void testDelete() {

        SObject currentObject = Schema.getGlobalDescribe().get(objectName).newSObject();
        currentObject.put('Name', targetName);

        Test.startTest();
        //Checking how the trigger works when inserting a record
        insert currentObject;

        //Checking how the trigger works when deleting a record
        delete currentObject;

        Test.stopTest();
    }

    @IsTest static void testUndelete() {

        SObject currentObject = Schema.getGlobalDescribe().get(objectName).newSObject();
        currentObject.put('Name', targetName);

        Test.startTest();
        //Checking how the trigger works when inserting a record
        insert currentObject;

        //Checking how the trigger works when deleting a record
        delete currentObject;

        undelete currentObject;

        Test.stopTest();
    }
}
