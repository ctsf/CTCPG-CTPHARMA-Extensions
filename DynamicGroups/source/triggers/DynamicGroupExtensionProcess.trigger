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

/**
 * SETUP THIS:
 * - Replace OBJECT_API_NAME with the api name of the object for which you want to enable Dynamic Groups.
 * - Replace PACKAGE_NAMESPACE with CTCPG or CTPHARMA.
 */

trigger DynamicGroupExtensionProcess on OBJECT_API_NAME (before delete, after insert, after update, after undelete) {

    if(Trigger.isInsert && Trigger.isAfter) {
        PACKAGE_NAMESPACE.GlobalDynamicGroups.calculateGroupMembers(Trigger.new, Trigger.oldMap, 'ai');
    }

    if(Trigger.isUpdate && Trigger.isAfter) {
        PACKAGE_NAMESPACE.GlobalDynamicGroups.calculateGroupMembers(Trigger.new, Trigger.oldMap, 'au');
    }

    if(Trigger.isUndelete && Trigger.isAfter) {
        PACKAGE_NAMESPACE.GlobalDynamicGroups.calculateGroupMembers(Trigger.new, Trigger.oldMap, 'aud');
    }

    if(Trigger.isDelete && Trigger.isBefore) {
        PACKAGE_NAMESPACE.GlobalDynamicGroups.deleteGroupMembers(Trigger.old);
    }
}
