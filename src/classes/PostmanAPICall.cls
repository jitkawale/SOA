/**************************************************************************************************************
Component Name: PostmanAPICall
Description : This class is used to call simple get API
Author : Jitendra Kawale (Jitkawale@gmail.com)
Date 20th July 2018
***************************************************************************************************************/
Public with sharing class PostmanAPICall {
    public static void callAPI() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://postman-echo.com/get?foo1=bar1&foo2=bar2');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            System.debug('Response in JSON==>'+response.getBody());
            System.debug('Parsed Response ==>'+ results);
            
        }
    }
}