//
//  ResourcesGraphDataService.swift
//
//
//  Created by Kristian Mitra on 2/17/24.
//

import DigitalAPIClient
import HWDBusinessModels
import HWDDataServiceProtocols
import Foundation

public struct ResourcesGraphDataService: ResourcesGraphDataServiceProtocol {
    
    // MARK: - Fields
    
    private let dataClient: DataClientProtocol
    
    // MARK: - Constructor
    
    public init(dataClient: DataClientProtocol?) {
        guard let _ = dataClient else { fatalError() }
        self.dataClient = dataClient!
    }
    
    // MARK: - Methods
    
    public func getStationsAsync() async -> [DigitalAPIClient.Components.Schemas.Station] {
        do
        {
            let client = await dataClient.getClientAsync()
            let stationsGraphSchema = DigitalAPIClient.Components.Schemas.GraphQlQueryv2.init(
                query: "query StationBusinessModel{q0: resourceStations(query: {activeOnly:true cultureCode:\"en-US\" }) { values {stationCode,fullName,allowed,class,conversionCurrencyCode,cultureCode,currencyCode,icaoCode,inActive,locationDetails {cityCode,coordinates {latitude,longitude},countryCode,customsRequiredForCrew,provinceStateCode,subZoneCode,thirdPartyControlled,timeZoneCode,zoneCode}macCode,shortName}eTag,expiration} }",
                variables: "")
            
            let results = try await client.v2_graph_queryName_post(
                path: .init(queryName: "StationsBusinessModel"),
                body: .json(stationsGraphSchema))
            
            let response = try results.ok.body.json.data?.value as? Dictionary<String, Dictionary<String, Any>>
            let innerDictionary = response?["q0"]?["values"] as? Array<Any>
            
            // temporary workaround. will need to convert to proper GraphQL API Client in the future
            let jsonData = try JSONSerialization.data(withJSONObject: innerDictionary ?? [Any]())
            let stations = try JSONDecoder().decode([DigitalAPIClient.Components.Schemas.Station].self, from: jsonData)

            return stations 
        }
        catch {
            print(error)
        }
        
        return [DigitalAPIClient.Components.Schemas.Station]()
    }
    
    public func getCitiesAsync() async -> [DigitalAPIClient.Components.Schemas.City] {
        do
        {
            let client = await dataClient.getClientAsync()
            let citiesGraphSchema = DigitalAPIClient.Components.Schemas.GraphQlQueryv2.init(
                query: "query CityBusinessModel{q0: resourceCities(query: {activeOnly:true cultureCode:\"en-US\" }){values {cityCode, countryCode, inActive, name, provinceStateCode, shortName}, eTag, expiration} }",
                variables: "")

            let results = try await client.v2_graph_queryName_post(
                path: .init(queryName: "CityBusinessModel"),
                body: .json(citiesGraphSchema))
            
            let response = try results.ok.body.json.data?.value as? Dictionary<String, Dictionary<String, Any>>
            let innerDictionary = response?["q0"]?["values"] as? Array<Any>
            
            // temporary workaround. will need to convert to proper GraphQL API Client in the future
            let jsonData = try JSONSerialization.data(withJSONObject: innerDictionary ?? [Any]())
            let cities = try JSONDecoder().decode([DigitalAPIClient.Components.Schemas.City].self, from: jsonData)

            return cities
        }
        catch {
            print(error)
        }
        
        return [DigitalAPIClient.Components.Schemas.City]()
    }
    
    public func getMarketsv2Async() async -> [DigitalAPIClient.Components.Schemas.Marketv2] {
        do
        {
            let client = await dataClient.getClientAsync()
            
            // note: excluded includesTaxesAndFees, default value: None
            // note: excluded locationType, travelLocationType, default value: Station
            // note: excluded travelLocationsRequired, default value: None
            let marketsv2GraphSchema = DigitalAPIClient.Components.Schemas.GraphQlQueryv2.init(
                query: "query Marketv2BusinessModel{q0: resourceMarketsv2(query: {activeOnly:true cultureCode:\"en-US\" }) {    values {      earliestCheckInFrom,      earliestCheckInTo,      inActive,      latestCheckInTo,      latestCheckInFrom,      locationCode,      travelLocationCode    }    eTag,    expiration  } }",
                variables: "")

            let results = try await client.v2_graph_queryName_post(
                path: .init(queryName: "Marketv2BusinessModel"),
                body: .json(marketsv2GraphSchema))
            
            let response = try results.ok.body.json.data?.value as? Dictionary<String, Dictionary<String, Any>>
            let innerDictionary = response?["q0"]?["values"] as? Array<Any>
            
            // temporary workaround. will need to convert to proper GraphQL API Client in the future
            let jsonData = try JSONSerialization.data(withJSONObject: innerDictionary ?? [Any]())
            let marketsv2 = try JSONDecoder().decode([DigitalAPIClient.Components.Schemas.Marketv2].self, from: jsonData)

            return marketsv2
        }
        catch {
            print(error)
        }
        
        return [DigitalAPIClient.Components.Schemas.Marketv2]()
    }
    
    public func getCountriesv2Async() async -> [DigitalAPIClient.Components.Schemas.Countryv2] {
        do
        {
            let client = await dataClient.getClientAsync()
            let countryv2GraphSchema = DigitalAPIClient.Components.Schemas.GraphQlQueryv2.init(
                query: "query Countryv2BusinessModel{q0: resourceCountriesv2(query: {activeOnly:true cultureCode:\"en-US\" }) {values {cities {name, cityCode,countryCode,inActive,provinceStateCode,shortName},name,countryCode,inActive,countryCode3C,defaultCurrencyCode,hasProvinceStates,provinceStates {name,cities{name,cityCode,countryCode,inActive,provinceStateCode,shortName},countryCode,provinceStateCode,inActive}},eTag,expiration} }",
                variables: "")

            let results = try await client.v2_graph_queryName_post(
                path: .init(queryName: "Countryv2BusinessModel"),
                body: .json(countryv2GraphSchema))
            
            let response = try results.ok.body.json.data?.value as? Dictionary<String, Dictionary<String, Any>>
            let innerDictionary = response?["q0"]?["values"] as? Array<Any>
            
            // temporary workaround. will need to convert to proper GraphQL API Client in the future
            let jsonData = try JSONSerialization.data(withJSONObject: innerDictionary ?? [Any]())
            let countryv2 = try JSONDecoder().decode([DigitalAPIClient.Components.Schemas.Countryv2].self, from: jsonData)

            return countryv2
        }
        catch {
            print(error)
        }
        
        return [DigitalAPIClient.Components.Schemas.Countryv2]()
    }
}
