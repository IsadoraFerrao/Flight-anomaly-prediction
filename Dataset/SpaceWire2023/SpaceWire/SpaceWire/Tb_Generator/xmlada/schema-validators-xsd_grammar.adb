------------------------------------------------------------------------------
--                     XML/Ada - An XML suite for Ada95                     --
--                                                                          --
--                     Copyright (C) 2004-2012, AdaCore                     --
--                                                                          --
-- This library is free software;  you can redistribute it and/or modify it --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software  Foundation;  either version 3,  or (at your  option) any later --
-- version. This library is distributed in the hope that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
------------------------------------------------------------------------------

with Sax.Encodings;
with Sax.Readers;           use Sax.Readers;
with Schema.Validators;     use Schema.Validators;
with Schema.Schema_Readers; use Schema.Schema_Readers;
with Input_Sources.Strings; use Input_Sources.Strings;

package body Schema.Validators.XSD_Grammar is

   --  The following metaschema is generated by ./cleanup_schema, which parses
   --  the normative schema.xsd and datatypes.xsd files.
   --  Embedding the string avoids relying on external files when running
   --  XML/Ada based applications

   pragma Warnings (Off);
   pragma Style_Checks (Off);
   Metaschema : aliased constant String :=
     "<?xml version='1.0'?><xs:schema xmlns:xs='http://www.w3.org/2001/XMLSchema' blockDefault='#all' elementFormDefault='qualified' xml:lang='EN' targetNamespace='http://www.w3.org/2001/XMLSchema' version='Id: structures.xsd,v 1.2 2004/01/15 11:34:25 ht Exp '><xs:simpleType name='derivationControl'><xs:restriction base='xs:NMTOKEN'><xs:enumeration value='substitution'/><xs:enumeration value='extension'/><xs:enumeration value='restriction'/><xs:enumeration value='list'/><xs:enumeration value='union'/></xs:restriction></xs:simpleType><xs:group name='simpleDerivation'><xs:choice><xs:element ref='xs:restriction'/><xs:element ref='xs:list'/><xs:element ref='xs:union'/></xs:choice></xs:group><xs:simpleType name='simpleDerivationSet'><xs:union><xs:simpleType><xs:restriction base='xs:token'><xs:enumeration value='#all'/></xs:restriction></xs:simpleType><xs:simpleType><xs:list><xs:simpleType><xs:restriction base='xs:derivationControl'><xs:enumeration value='list'/><xs:enumeration value='union'/><xs:enumeration value='restriction'/></xs:restriction></xs:simpleType></xs:list></xs:simpleType></xs:union></xs:simpleType><xs:complexType name='simpleType' abstract='true'><xs:complexContent><xs:extension base='xs:annotated'><xs:group ref='xs:simpleDerivation'/><xs:attribute name='final' type='xs:simpleDerivationSet'/><xs:attribute name='name' type='xs:NCName'></xs:attribute></xs:extension></xs:complexContent></xs:complexType><xs:complexType name='topLevelSimpleType'><xs:complexContent><xs:restriction base='xs:simpleType'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:group ref='xs:simpleDerivation'/></xs:sequence><xs:attribute name='name' type='xs:NCName' use='required'></xs:attribute><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='localSimpleType'><xs:complexContent><xs:restriction base='xs:simpleType'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:group ref='xs:simpleDerivation'/></xs:sequence><xs:attribute name='name' use='prohibited'></xs:attribute><xs:attribute name='final' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:element name='simpleType' type='xs:topLevelSimpleType' id='simpleType'></xs:element><xs:group name='facets'><xs:choice><xs:element ref='xs:minExclusive'/><xs:element ref='xs:minInclusive'/><xs:element ref='xs:maxExclusive'/><xs:element ref='xs:maxInclusive'/><xs:element ref='xs:totalDigits'/><xs:element ref='xs:fractionDigits'/><xs:element ref='xs:length'/><xs:element ref='xs:minLength'/><xs:element ref='xs:maxLength'/><xs:element ref='xs:enumeration'/><xs:element ref='xs:whiteSpace'/><xs:element ref='xs:pattern'/></xs:choice></xs:group><xs:group name='simpleRestrictionModel'><xs:sequence><xs:element name='simpleType' type='xs:localSimpleType' minOccurs='0'/><xs:group ref='xs:facets' minOccurs='0' maxOccurs='unbounded'/></xs:sequence></xs:group><xs:element name='restriction' id='restriction'><xs:complexType><xs:complexContent><xs:extension base='xs:annotated'><xs:group ref='xs:simpleRestrictionModel'/><xs:attribute name='base' type='xs:QName' use='optional'/></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:element name='list' id='list'><xs:complexType><xs:complexContent><xs:extension base='xs:annotated'><xs:sequence><xs:element name='simpleType' type='xs:localSimpleType' minOccurs='0'/></xs:sequence><xs:attribute name='itemType' type='xs:QName' use='optional'/></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:element name='union' id='union'><xs:complexType><xs:complexContent><xs:extension base='xs:annotated'><xs:sequence><xs:element name='simpleType' type='xs:localSimpleType' minOccurs='0' maxOccurs='unbounded'/></xs:sequence><xs:attribute name='memberTypes' use='optional'><xs:simpleType><xs:list itemType='xs:QName'/></xs:simpleType></xs:attribute></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:complexType name='facet'><xs:complexContent><xs:extension base='xs:annotated'><xs:attribute name='value' use='required'/><xs:attribute name='fixed' type='xs:boolean' default='false' use='optional'/></xs:extension></xs:complexContent></xs:complexType><xs:complexType name='noFixedFacet'><xs:complexContent><xs:restriction base='xs:facet'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/></xs:sequence><xs:attribute name='fixed' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:element name='minExclusive' type='xs:facet' id='minExclusive'></xs:element><xs:element name='minInclusive' type='xs:facet' id='minInclusive'></xs:element><xs:element name='maxExclusive' type='xs:facet' id='maxExclusive'></xs:element><xs:element name='maxInclusive' type='xs:facet' id='maxInclusive'></xs:element><xs:complexType name='numFacet'><xs:complexContent><xs:restriction base='xs:facet'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/></xs:sequence><xs:attribute name='value' type='xs:nonNegativeInteger' use='required'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:element name='totalDigits' id='totalDigits'><xs:complexType><xs:complexContent><xs:restriction base='xs:numFacet'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/></xs:sequence><xs:attribute name='value' type='xs:positiveInteger' use='required'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType></xs:element><xs:element name='fractionDigits' type='xs:numFacet' id='fractionDigits'></xs:element><xs:element name='length' type='xs:numFacet' id='length'></xs:element><xs:element name='minLength' type='xs:numFacet' id='minLength'></xs:element><xs:element name='maxLength' type='xs:numFacet' id='maxLength'></xs:element><xs:element name='enumeration' type='xs:noFixedFacet' id='enumeration'></xs:element><xs:element name='whiteSpace' id='whiteSpace'><xs:complexType><xs:complexContent><xs:restriction base='xs:facet'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/></xs:sequence><xs:attribute name='value' use='required'><xs:simpleType><xs:restriction base='xs:NMTOKEN'><xs:enumeration value='preserve'/><xs:enumeration value='replace'/><xs:enumeration value='collapse'/></xs:restriction></xs:simpleType></xs:attribute><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType></xs:element><xs:element name='pattern' id='pattern'><xs:complexType><xs:complexContent><xs:restriction base='xs:noFixedFacet'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/></xs:sequence><xs:attribute name='value' type='xs:string' use='required'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType></xs:element><xs:complexType name='openAttrs'><xs:complexContent><xs:restriction base='xs:anyType'><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='annotated'><xs:complexContent><xs:extension base='xs:openAttrs'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/></xs:sequence><xs:attribute name='id' type='xs:ID'/></xs:extension></xs:complexContent></xs:complexType><xs:group name='schemaTop'><xs:choice><xs:group ref='xs:redefinable'/><xs:element ref='xs:element'/><xs:element ref='xs:attribute'/><xs:element ref='xs:notation'/></xs:choice></xs:group><xs:group name='redefinable'><xs:choice><xs:element ref='xs:simpleType'/><xs:element ref='xs:complexType'/><xs:element ref='xs:group'/><xs:element ref='xs:attributeGroup'/></xs:choice></xs:group><xs:simpleType name='formChoice'><xs:restriction base='xs:NMTOKEN'><xs:enumeration value='qualified'/><xs:enumeration value='unqualified'/></xs:restriction></xs:simpleType><xs:simpleType name='reducedDerivationControl'><xs:restriction base='xs:derivationControl'><xs:enumeration value='extension'/><xs:enumeration value='restriction'/></xs:restriction></xs:simpleType><xs:simpleType name='derivationSet'><xs:union><xs:simpleType><xs:restriction base='xs:token'><xs:enumeration value='#all'/></xs:restriction></xs:simpleType><xs:simpleType><xs:list itemType='xs:reducedDerivationControl'/></xs:simpleType></xs:union></xs:simpleType><xs:simpleType name='typeDerivationControl'><xs:restriction base='xs:derivationControl'><xs:enumeration value='extension'/><xs:enumeration value='restriction'/><xs:enumeration value='list'/><xs:enumeration value='union'/></xs:restriction></xs:simpleType><xs:simpleType name='fullDerivationSet'><xs:union><xs:simpleType><xs:restriction base='xs:token'><xs:enumeration value='#all'/></xs:restriction></xs:simpleType><xs:simpleType><xs:list itemType='xs:typeDerivationControl'/></xs:simpleType></xs:union></xs:simpleType><xs:element name='schema' id='schema'><xs:complexType><xs:complexContent><xs:extension base='xs:openAttrs'><xs:sequence><xs:choice minOccurs='0' maxOccurs='unbounded'><xs:element ref='xs:include'/><xs:element ref='xs:import'/><xs:element ref='xs:redefine'/><xs:element ref='xs:annotation'/></xs:choice><xs:sequence minOccurs='0' maxOccurs='unbounded'><xs:group ref='xs:schemaTop'/><xs:element ref='xs:annotation' minOccurs='0' maxOccurs='unbounded'/></xs:sequence></xs:sequence><xs:attribute name='targetNamespace' type='xs:anyURI'/><xs:attribute name='version' type='xs:token'/><xs:attribute name='finalDefault' type='xs:fullDerivationSet' default='' use='optional'/><xs:attribute name='blockDefault' type='xs:blockSet' default='' use='optional'/><xs:attribute name='attributeFormDefault' type='xs:formChoice' default='unqualified' use='optional'/><xs:attribute name='elementFormDefault' type='xs:formChoice' default='unqualified' use='optional'/><xs:attribute name='id' type='xs:ID'/><xs:attribute ref='xml:lang'/></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:simpleType name='allNNI'><xs:union memberTypes='xs:nonNegativeInteger'><xs:simpleType><xs:restriction base='xs:NMTOKEN'><xs:enumeration value='unbounded'/></xs:restriction></xs:simpleType></xs:union></xs:simpleType><xs:attributeGroup name='occurs'><xs:attribute name='minOccurs' type='xs:nonNegativeInteger' default='1' use='optional'/><xs:attribute name='maxOccurs' type='xs:allNNI' default='1' use='optional'/></xs:attributeGroup><xs:attributeGroup name='defRef'><xs:attribute name='name' type='xs:NCName'/><xs:attribute name='ref' type='xs:QName'/></xs:attributeGroup><xs:group name='typeDefParticle'><xs:choice><xs:element name='group' type='xs:groupRef'/><xs:element ref='xs:all'/><xs:element ref='xs:choice'/><xs:element ref='xs:sequence'/></xs:choice></xs:group><xs:group name='nestedParticle'><xs:choice><xs:element name='element' type='xs:localElement'/><xs:element name='group' type='xs:groupRef'/><xs:element ref='xs:choice'/><xs:element ref='xs:sequence'/><xs:element ref='xs:any'/></xs:choice></xs:group><xs:group name='particle'><xs:choice><xs:element name='element' type='xs:localElement'/><xs:element name='group' type='xs:groupRef'/><xs:element ref='xs:all'/><xs:element ref='xs:choice'/><xs:element ref='xs:sequence'/><xs:element ref='xs:any'/></xs:choice></xs:group><xs:complexType name='attribute'><xs:complexContent><xs:extension base='xs:annotated'><xs:sequence><xs:element name='simpleType' type='xs:localSimpleType' minOccurs='0'/></xs:sequence><xs:attributeGroup ref='xs:defRef'/><xs:attribute name='type' type='xs:QName'/><xs:attribute name='use' default='optional' use='optional'><xs:simpleType><xs:restriction base='xs:NMTOKEN'><xs:enumeration value='prohibited'/><xs:enumeration value='optional'/><xs:enumeration value='required'/></xs:restriction></xs:simpleType></xs:attribute><xs:attribute name='default' type='xs:string'/><xs:attribute name='fixed' type='xs:string'/><xs:attribute name='form' type='xs:formChoice'/></xs:extension></xs:complexContent></xs:complexType><xs:complexType name='topLevelAttribute'><xs:complexContent><xs:restriction base='xs:attribute'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:element name='simpleType' type='xs:localSimpleType' minOccurs='0'/></xs:sequence><xs:attribute name='ref' use='prohibited'/><xs:attribute name='form' use='prohibited'/><xs:attribute name='use' use='prohibited'/><xs:attribute name='name' type='xs:NCName' use='required'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:group name='attrDecls'><xs:sequence><xs:choice minOccurs='0' maxOccurs='unbounded'><xs:element name='attribute' type='xs:attribute'/><xs:element name='attributeGroup' type='xs:attributeGroupRef'/></xs:choice><xs:element ref='xs:anyAttribute' minOccurs='0'/></xs:sequence></xs:group><xs:element name='anyAttribute' type='xs:wildcard' id='anyAttribute'></xs:element><xs:group name='complexTypeModel'><xs:choice><xs:element ref='xs:simpleContent'/><xs:element ref='xs:complexContent'/><xs:sequence><xs:group ref='xs:typeDefParticle' minOccurs='0'/><xs:group ref='xs:attrDecls'/></xs:sequence></xs:choice></xs:group><xs:complexType name='complexType' abstract='true'><xs:complexContent><xs:extension base='xs:annotated'><xs:group ref='xs:complexTypeModel'/><xs:attribute name='name' type='xs:NCName'></xs:attribute><xs:attribute name='mixed' type='xs:boolean' default='false' use='optional'></xs:attribute><xs:attribute name='abstract' type='xs:boolean' default='false' use='optional'/><xs:attribute name='final' type='xs:derivationSet'/><xs:attribute name='block' type='xs:derivationSet'/></xs:extension></xs:complexContent></xs:complexType><xs:complexType name='topLevelComplexType'><xs:complexContent><xs:restriction base='xs:complexType'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:group ref='xs:complexTypeModel'/></xs:sequence><xs:attribute name='name' type='xs:NCName' use='required'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='localComplexType'><xs:complexContent><xs:restriction base='xs:complexType'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:group ref='xs:complexTypeModel'/></xs:sequence><xs:attribute name='name' use='prohibited'/><xs:attribute name='abstract' use='prohibited'/><xs:attribute name='final' use='prohibited'/><xs:attribute name='block' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='restrictionType'><xs:complexContent><xs:extension base='xs:annotated'><xs:sequence><xs:choice minOccurs='0'><xs:group ref='xs:typeDefParticle'/><xs:group ref='xs:simpleRestrictionModel'/></xs:choice><xs:group ref='xs:attrDecls'/></xs:sequence><xs:attribute name='base' type='xs:QName' use='required'/></xs:extension></xs:complexContent></xs:complexType><xs:complexType name='complexRestrictionType'><xs:complexContent><xs:restriction base='xs:restrictionType'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:choice minOccurs='0'><xs:group ref='xs:typeDefParticle'/></xs:choice><xs:group ref='xs:attrDecls'/></xs:sequence><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='extensionType'><xs:complexContent><xs:extension base='xs:annotated'><xs:sequence><xs:group ref='xs:typeDefParticle' minOccurs='0'/><xs:group ref='xs:attrDecls'/></xs:sequence><xs:attribute name='base' type='xs:QName' use='required'/></xs:extension></xs:complexContent></xs:complexType><xs:element name='complexContent' id='complexContent'><xs:complexType><xs:complexContent><xs:extension base='xs:annotated'><xs:choice><xs:element name='restriction' type='xs:complexRestrictionType'/><xs:element name='extension' type='xs:extensionType'/></xs:choice><xs:attribute name='mixed' type='xs:boolean'></xs:attribute></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:complexType name='simpleRestrictionType'><xs:complexContent><xs:restriction base='xs:restrictionType'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:choice minOccurs='0'><xs:group ref='xs:simpleRestrictionModel'/></xs:choice><xs:group ref='xs:attrDecls'/></xs:sequence><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='simpleExtensionType'><xs:complexContent><xs:restriction base='xs:extensionType'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:group ref='xs:attrDecls'/></xs:sequence><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:element name='simpleContent' id='simpleContent'><xs:complexType><xs:complexContent><xs:extension base='xs:annotated'><xs:choice><xs:element name='restriction' type='xs:simpleRestrictionType'/><xs:element name='extension' type='xs:simpleExtensionType'/></xs:choice></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:element name='complexType' type='xs:topLevelComplexType' id='complexType'></xs:element><xs:simpleType name='blockSet'><xs:union><xs:simpleType><xs:restriction base='xs:token'><xs:enumeration value='#all'/></xs:restriction></xs:simpleType><xs:simpleType><xs:list><xs:simpleType><xs:restriction base='xs:derivationControl'><xs:enumeration value='extension'/><xs:enumeration value='restriction'/><xs:enumeration value='substitution'/></xs:restriction></xs:simpleType></xs:list></xs:simpleType></xs:union></xs:simpleType><xs:complexType name='element' abstract='true'><xs:complexContent><xs:extension base='xs:annotated'><xs:sequence><xs:choice minOccurs='0'><xs:element name='simpleType' type='xs:localSimpleType'/><xs:element name='complexType' type='xs:localComplexType'/></xs:choice><xs:group ref='xs:identityConstraint' minOccurs='0' maxOccurs='unbounded'/></xs:sequence><xs:attributeGroup ref='xs:defRef'/><xs:attribute name='type' type='xs:QName'/><xs:attribute name='substitutionGroup' type='xs:QName'/><xs:attributeGroup ref='xs:occurs'/><xs:attribute name='default' type='xs:string'/><xs:attribute name='fixed' type='xs:string'/><xs:attribute name='nillable' type='xs:boolean' default='false' use='optional'/><xs:attribute name='abstract' type='xs:boolean' default='false' use='optional'/><xs:attribute name='final' type='xs:derivationSet'/><xs:attribute name='block' type='xs:blockSet'/><xs:attribute name='form' type='xs:formChoice'/></xs:extension></xs:complexContent></xs:complexType><xs:complexType name='topLevelElement'><xs:complexContent><xs:restriction base='xs:element'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:choice minOccurs='0'><xs:element name='simpleType' type='xs:localSimpleType'/><xs:element name='complexType' type='xs:localComplexType'/></xs:choice><xs:group ref='xs:identityConstraint' minOccurs='0' maxOccurs='unbounded'/></xs:sequence><xs:attribute name='ref' use='prohibited'/><xs:attribute name='form' use='prohibited'/><xs:attribute name='minOccurs' use='prohibited'/><xs:attribute name='maxOccurs' use='prohibited'/><xs:attribute name='name' type='xs:NCName' use='required'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='localElement'><xs:complexContent><xs:restriction base='xs:element'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:choice minOccurs='0'><xs:element name='simpleType' type='xs:localSimpleType'/><xs:element name='complexType' type='xs:localComplexType'/></xs:choice><xs:group ref='xs:identityConstraint' minOccurs='0' maxOccurs='unbounded'/></xs:sequence><xs:attribute name='substitutionGroup' use='prohibited'/><xs:attribute name='final' use='prohibited'/><xs:attribute name='abstract' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:element name='element' type='xs:topLevelElement' id='element'></xs:element><xs:complexType name='group' abstract='true'><xs:complexContent><xs:extension base='xs:annotated'><xs:group ref='xs:particle' minOccurs='0' maxOccurs='unbounded'/><xs:attributeGroup ref='xs:defRef'/><xs:attributeGroup ref='xs:occurs'/></xs:extension></xs:complexContent></xs:complexType><xs:complexType name='realGroup'><xs:complexContent><xs:restriction base='xs:group'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:choice minOccurs='0' maxOccurs='1'><xs:element ref='xs:all'/><xs:element ref='xs:choice'/><xs:element ref='xs:sequence'/></xs:choice></xs:sequence><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='namedGroup'><xs:complexContent><xs:restriction base='xs:realGroup'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:choice minOccurs='1' maxOccurs='1'><xs:element name='all'><xs:complexType><xs:complexContent><xs:restriction base='xs:all'><xs:group ref='xs:allModel'/><xs:attribute name='minOccurs' use='prohibited'/><xs:attribute name='maxOccurs' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType></xs:element><xs:element name='choice' type='xs:simpleExplicitGroup'/><xs:element name='sequence' type='xs:simpleExplicitGroup'/></xs:choice></xs:sequence><xs:attribute name='name' type='xs:NCName' use='required'/><xs:attribute name='ref' use='prohibited'/><xs:attribute name='minOccurs' use='prohibited'/><xs:attribute name='maxOccurs' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='groupRef'><xs:complexContent><xs:restriction base='xs:realGroup'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/></xs:sequence><xs:attribute name='ref' type='xs:QName' use='required'/><xs:attribute name='name' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='explicitGroup'><xs:complexContent><xs:restriction base='xs:group'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:group ref='xs:nestedParticle' minOccurs='0' maxOccurs='unbounded'/></xs:sequence><xs:attribute name='name' type='xs:NCName' use='prohibited'/><xs:attribute name='ref' type='xs:QName' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='simpleExplicitGroup'><xs:complexContent><xs:restriction base='xs:explicitGroup'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:group ref='xs:nestedParticle' minOccurs='0' maxOccurs='unbounded'/></xs:sequence><xs:attribute name='minOccurs' use='prohibited'/><xs:attribute name='maxOccurs' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:group name='allModel'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:choice minOccurs='0' maxOccurs='unbounded'><xs:element name='element' type='xs:narrowMaxMin'/></xs:choice></xs:sequence></xs:group><xs:complexType name='narrowMaxMin'><xs:complexContent><xs:restriction base='xs:localElement'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:choice minOccurs='0'><xs:element name='simpleType' type='xs:localSimpleType'/><xs:element name='complexType' type='xs:localComplexType'/></xs:choice><xs:group ref='xs:identityConstraint' minOccurs='0' maxOccurs='unbounded'/></xs:sequence><xs:attribute name='minOccurs' default='1' use='optional'><xs:simpleType><xs:restriction base='xs:nonNegativeInteger'><xs:enumeration value='0'/><xs:enumeration value='1'/></xs:restriction></xs:simpleType></xs:attribute><xs:attribute name='maxOccurs' default='1' use='optional'><xs:simpleType><xs:restriction base='xs:allNNI'><xs:enumeration value='0'/><xs:enumeration value='1'/></xs:restriction></xs:simpleType></xs:attribute><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='all'><xs:complexContent><xs:restriction base='xs:explicitGroup'><xs:group ref='xs:allModel'/><xs:attribute name='minOccurs' default='1' use='optional'><xs:simpleType><xs:restriction base='xs:nonNegativeInteger'><xs:enumeration value='0'/><xs:enumeration value='1'/></xs:restriction></xs:simpleType></xs:attribute><xs:attribute name='maxOccurs' default='1' use='optional'><xs:simpleType><xs:restriction base='xs:allNNI'><xs:enumeration value='1'/></xs:restriction></xs:simpleType></xs:attribute><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:element name='all' type='xs:all' id='all'></xs:element><xs:element name='choice' type='xs:explicitGroup' id='choice'></xs:element><xs:element name='sequence' type='xs:explicitGroup' id='sequence'></xs:element><xs:element name='group' type='xs:namedGroup' id='group'></xs:element><xs:complexType name='wildcard'><xs:complexContent><xs:extension base='xs:annotated'><xs:attribute name='namespace' type='xs:namespaceList' default='##any' use='optional'/><xs:attribute name='processContents' default='strict' use='optional'><xs:simpleType><xs:restriction base='xs:NMTOKEN'><xs:enumeration value='skip'/><xs:enumeration value='lax'/><xs:enumeration value='strict'/></xs:restriction></xs:simpleType></xs:attribute></xs:extension></xs:complexContent></xs:complexType><xs:element name='any' id='any'><xs:complexType><xs:complexContent><xs:extension base='xs:wildcard'><xs:attributeGroup ref='xs:occurs'/></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:simpleType name='namespaceList'><xs:union><xs:simpleType><xs:restriction base='xs:token'><xs:enumeration value='##any'/><xs:enumeration value='##other'/></xs:restriction></xs:simpleType><xs:simpleType><xs:list><xs:simpleType><xs:union memberTypes='xs:anyURI'><xs:simpleType><xs:restriction base='xs:token'><xs:enumeration value='##targetNamespace'/><xs:enumeration value='##local'/></xs:restriction></xs:simpleType></xs:union></xs:simpleType></xs:list></xs:simpleType></xs:union></xs:simpleType><xs:element name='attribute' type='xs:topLevelAttribute' id='attribute'></xs:element><xs:complexType name='attributeGroup' abstract='true'><xs:complexContent><xs:extension base='xs:annotated'><xs:group ref='xs:attrDecls'/><xs:attributeGroup ref='xs:defRef'/></xs:extension></xs:complexContent></xs:complexType><xs:complexType name='namedAttributeGroup'><xs:complexContent><xs:restriction base='xs:attributeGroup'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/><xs:group ref='xs:attrDecls'/></xs:sequence><xs:attribute name='name' type='xs:NCName' use='required'/><xs:attribute name='ref' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:complexType name='attributeGroupRef'><xs:complexContent><xs:restriction base='xs:attributeGroup'><xs:sequence><xs:element ref='xs:annotation' minOccurs='0'/></xs:sequence><xs:attribute name='ref' type='xs:QName' use='required'/><xs:attribute name='name' use='prohibited'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:restriction></xs:complexContent></xs:complexType><xs:element name='attributeGroup' type='xs:namedAttributeGroup' id='attributeGroup'></xs:element><xs:element name='include' id='include'><xs:complexType><xs:complexContent><xs:extension base='xs:annotated'><xs:attribute name='schemaLocation' type='xs:anyURI' use='required'/></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:element name='redefine' id='redefine'><xs:complexType><xs:complexContent><xs:extension base='xs:openAttrs'><xs:choice minOccurs='0' maxOccurs='unbounded'><xs:element ref='xs:annotation'/><xs:group ref='xs:redefinable'/></xs:choice><xs:attribute name='schemaLocation' type='xs:anyURI' use='required'/><xs:attribute name='id' type='xs:ID'/></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:element name='import' id='import'><xs:complexType><xs:complexContent><xs:extension base='xs:annotated'><xs:attribute name='namespace' type='xs:anyURI'/><xs:attribute name='schemaLocation' type='xs:anyURI'/></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:element name='selector' id='selector'><xs:complexType><xs:complexContent><xs:extension base='xs:annotated'><xs:attribute name='xpath' use='required'><xs:simpleType><xs:restriction base='xs:token'><xs:pattern value='(\.//)?(((child::)?((\i\c*:)?(\i\c*|\*)))|\.)(/(((child::)?((\i\c*:)?(\i\c*|\*)))|\.))*(\|(\.//)?(((child::)?((\i\c*:)?(\i\c*|\*)))|\.)(/(((child::)?((\i\c*:)?(\i\c*|\*)))|\.))*)*'/></xs:restriction></xs:simpleType></xs:attribute></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:element name='field' id='field'><xs:complexType><xs:complexContent><xs:extension base='xs:annotated'><xs:attribute name='xpath' use='required'><xs:simpleType><xs:restriction base='xs:token'><xs:pattern value='(\.//)?((((child::)?((\i\c*:)?(\i\c*|\*)))|\.)/)*((((child::)?((\i\c*:)?(\i\c*|\*)))|\.)|((attribute::|@)((\i\c*:)?(\i\c*|\*))))(\|(\.//)?((((child::)?((\i\c*:)?(\i\c*|\*)))|\.)/)*((((child::)?((\i\c*:)?(\i\c*|\*)))|\.)|((attribute::|@)((\i\c*:)?(\i\c*|\*)))))*'/></xs:restriction></xs:simpleType></xs:attribute></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:complexType name='keybase'><xs:complexContent><xs:extension base='xs:annotated'><xs:sequence><xs:element ref='xs:selector'/><xs:element ref='xs:field' minOccurs='1' maxOccurs='unbounded'/></xs:sequence><xs:attribute name='name' type='xs:NCName' use='required'/></xs:extension></xs:complexContent></xs:complexType><xs:group name='identityConstraint'><xs:choice><xs:element ref='xs:unique'/><xs:element ref='xs:key'/><xs:element ref='xs:keyref'/></xs:choice></xs:group><xs:element name='unique' type='xs:keybase' id='unique'></xs:element><xs:element name='key' type='xs:keybase' id='key'></xs:element><xs:element name='keyref' id='keyref'><xs:complexType><xs:complexContent><xs:extension base='xs:keybase'><xs:attribute name='refer' type='xs:QName' use='required'/></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:element name='notation' id='notation'><xs:complexType><xs:complexContent><xs:extension base='xs:annotated'><xs:attribute name='name' type='xs:NCName' use='required'/><xs:attribute name='public' type='xs:public'/><xs:attribute name='system' type='xs:anyURI'/></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:simpleType name='public'><xs:restriction base='xs:token'/></xs:simpleType><xs:element name='appinfo' id='appinfo'><xs:complexType mixed='true'><xs:sequence minOccurs='0' maxOccurs='unbounded'><xs:any processContents='lax'/></xs:sequence><xs:attribute name='source' type='xs:anyURI'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:complexType></xs:element><xs:element name='documentation' id='documentation'><xs:complexType mixed='true'><xs:sequence minOccurs='0' maxOccurs='unbounded'><xs:any processContents='lax'/></xs:sequence><xs:attribute name='source' type='xs:anyURI'/><xs:attribute ref='xml:lang'/><xs:anyAttribute namespace='##other' processContents='lax'/></xs:complexType></xs:element><xs:element name='annotation' id='annotation'><xs:complexType><xs:complexContent><xs:extension base='xs:openAttrs'><xs:choice minOccurs='0' maxOccurs='unbounded'><xs:element ref='xs:appinfo'/><xs:element ref='xs:documentation'/></xs:choice><xs:attribute name='id' type='xs:ID'/></xs:extension></xs:complexContent></xs:complexType></xs:element><xs:notation name='XMLSchemaStructures' public='structures' system='http://www.w3.org/2000/08/XMLSchema.xsd'/><xs:notation name='XML' public='REC-xml-19980210' system='http://www.w3.org/TR/1998/REC-xml-19980210'/><xs:complexType name='anyType' mixed='true'><xs:sequence><xs:any minOccurs='0' maxOccurs='unbounded' processContents='lax'/></xs:sequence><xs:anyAttribute processContents='lax'/></xs:complexType></xs:schema>";
   pragma Style_Checks (On);
   pragma Warnings (On);

   procedure Add_Schema_For_Schema
     (R : in out Schema.Validators.Abstract_Validation_Reader'Class)
   is
      Schema : Schema_Reader;
      Input  : String_Input;
   begin
      if Debug then
         Debug_Output ("Add metaschema to the grammar");
      end if;

      Set_Grammar (Schema, R.Grammar);
      Set_Feature (Schema, Schema_Validation_Feature, False);

      Open (Metaschema'Access,
            Encoding => Sax.Encodings.Encoding,
            Input    => Input);
      Parse (Schema, Input);
      Close (Input);

   exception
      when XML_Not_Implemented | XML_Validation_Error =>
         R.Error_Msg := Schema.Error_Msg;
         R.Error_Location := Schema.Error_Location;
         raise;
   end Add_Schema_For_Schema;

end Schema.Validators.XSD_Grammar;
