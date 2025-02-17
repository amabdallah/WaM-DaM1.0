﻿--4.7 Rules

/*
This query shows an example Rule for an attribute called........., their attributes, units, object names, and instances, and data source 
for all the parameters in WaM-DaM

Result:
users can import the data values to their model. WaM-DaM keeps track of the meanings of data values, their units, 
to what instance they apply too.... 
*/

SELECT NativeObjectName,
InstanceName,
Attributes.NativeAttributeName,
"Units"."UnitName",
Mapping.AttributeTypeCodeCV,
RuleVariableOrder,
"AttributesRuleVariables"."NativeAttributeName" AS "RuleVariable",
NumConstant,
SymbolCV,
"MetadataRuleVariables"."AttributeTypeCodeCV" AS RuleVariableTypeCodeCV,
"RuleVariablesUnits"."UnitName" AS "RuleVariableUnitName"

FROM "DataStructures"

Left JOIN "ObjectTypes" 
ON "ObjectTypes"."DataStructureID"="DataStructures"."DataStructureID"

Left JOIN  "ObjectAttributes"
ON "ObjectAttributes"."ObjectTypeID"="ObjectTypes"."ObjectTypeID"

Left JOIN  "Attributes"
ON "Attributes"."AttributeID"="ObjectAttributes"."AttributeID"


Left JOIN "Units" 
ON "Units"."UnitID"="Attributes"."UnitID"

Left JOIN "Mapping"
ON "Mapping"."ObjectAttributeID"="ObjectAttributes"."ObjectAttributeID"

Left JOIN "Instances" 
ON "Instances"."InstanceID"="Mapping"."InstanceID"

Left JOIN "DataStorage" 
ON "DataStorage"."DataStorageID"="Mapping"."DataStorageID"

LEFT JOIN "ScenarioMapping"
ON "ScenarioMapping"."MappingID"="Mapping"."MappingID"

Left JOIN "Scenarios" 
ON "Scenarios"."ScenarioID"="ScenarioMapping"."ScenarioID"

Left JOIN "MasterNetworks" 
ON "MasterNetworks"."MasterNetworkID"="Scenarios"."ScenarioID"

Left JOIN "Rules" 
ON "Rules"."DataStorageID"="DataStorage"."DataStorageID"

/*This is extra join to get the rule variable names */

Left JOIN "DataStorage" As "RuleVariables"
ON "RuleVariables"."DataStorageID"="Rules"."RuleVariableID"

Left JOIN "Mapping" As "MetadataRuleVariables"
ON "MetadataRuleVariables"."DataStorageID"="RuleVariables"."DataStorageID"

Left JOIN  "ObjectAttributes" As "ObjAttRuleVariables"
ON "ObjAttRuleVariables"."ObjectAttributeID"="MetadataRuleVariables"."ObjectAttributeID"

Left JOIN  "Attributes" AS "AttributesRuleVariables"
ON "AttributesRuleVariables"."AttributeID"="ObjAttRuleVariables"."AttributeID"

Left JOIN "Units" As "RuleVariablesUnits"
ON "RuleVariablesUnits"."UnitID"="AttributesRuleVariables"."UnitID"

/* Finishes here */

WHERE  Attributes.NativeAttributeName='Loss to Groundwater'  AND InstanceName='Hyrum (10)' AND ScenarioName='BaseCaseLower'

order by RuleVariableOrder ASC