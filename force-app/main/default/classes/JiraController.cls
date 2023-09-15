public class JiraController {
    public static void getAllIssues(string startAt){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //get API KEY from custom metadata
        Jira_Api_Key__c jiraApiKey = Jira_Api_Key__c.getOrgDefaults();

        string apiKey = jiraApiKey.api_key__c;
        string userName = 'pdjordjevic@k2partnering.com';
       
        String auth_header = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(userName + ':' + apiKey));
		System.debug(auth_header);
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept-Encoding', 'application/json');
        req.setHeader('accept','application/json');
        req.setHeader('Authorization',auth_header);
        req.setMethod('GET');
        req.setEndpoint('https://cloudpacific.atlassian.net/rest/api/latest/search?jql=project=NB&maxResults=10000&fields=customfield_10088&startAt='+startAt);
        HttpResponse res = h.send(req);
        System.debug(String.valueOf(res.getBody()));
             jiraWrapper wrapperList =(jiraWrapper) JSON.deserialize(res.getBody(),jiraWrapper.class);
        if(wrapperList!=null){
        for(issuesWrapper issue : wrapperList.issues){
            string components = issue.fields.get('customfield_10088');
            if(components != null){
               System.debug(issue.key);
               System.debug(components);
            }
        }
	}
}
    @future(callout=true)
    public static void createComponent(string componentName){
         Http h = new Http();
        HttpRequest req = new HttpRequest();
        //get API KEY from custom metadata
        Jira_Api_Key__c jiraApiKey = Jira_Api_Key__c.getOrgDefaults();

        string apiKey = jiraApiKey.api_key__c;
        string userName = 'pdjordjevic@k2partnering.com';
       
        String auth_header = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(userName + ':' + apiKey));
		System.debug(auth_header);
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept-Encoding', 'application/json');
        req.setHeader('accept','application/json');
        req.setHeader('Authorization',auth_header);
        req.setMethod('POST');
        string body = '{ "description": "This is a TMO component","name": "'+componentName+'","project": "NB"}';
		req.setBody(body);
        req.setEndpoint('https://cloudpacific.atlassian.net/rest/api/latest/component');
        HttpResponse res = h.send(req);
		System.debug(res.getBodY());
    }
   @future(callout=true)
    public static void attachComponent(string componentName,string issueKey){
         Http h = new Http();
        HttpRequest req = new HttpRequest();
        //get API KEY from custom metadata
        Jira_Api_Key__c jiraApiKey = Jira_Api_Key__c.getOrgDefaults();

        string apiKey = jiraApiKey.api_key__c;
        string userName = 'pdjordjevic@k2partnering.com';
       
        String auth_header = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(userName + ':' + apiKey));
		System.debug(auth_header);
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept-Encoding', 'application/json');
        req.setHeader('accept','application/json');
        req.setHeader('Authorization',auth_header);
        req.setMethod('PUT');
        string body = '{ "update": { "components": [ { "add": { "name": "'+componentName+'" } } ] } }';
		req.setBody(body);
        req.setEndpoint('https://cloudpacific.atlassian.net/rest/api/latest/issue/'+issueKey);
        HttpResponse res = h.send(req);
		System.debug(res.getBodY());
    }
   
    public class issuesWrapper{
    public string key;
    public Map<String,String> fields;
	}
    public class jiraWrapper{
        public List<issuesWrapper> issues;
    }
    
	
}