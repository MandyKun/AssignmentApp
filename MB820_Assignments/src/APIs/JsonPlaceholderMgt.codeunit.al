codeunit 50204 JsonPlaceholderMgt
{
    procedure GetToDos()
    var
        Client: HttpClient;
        ResponseContent: HttpResponseMessage;
        Content: HttpContent;
        ResponseString: Text;
        TestString, Title : Text;
        JArray: JsonArray;
        JsonObject: JsonObject;
        JsonTokenType, ResultToken : JsonToken;
        AssignementMgt: Codeunit AssignmentMgt;

        UserId, Id : Integer;
        Completed: Boolean;
    begin
        //Request data from https://jsonplaceholder.typicode.com/todos
        if not Client.Get('https://jsonplaceholder.typicode.com/todos', ResponseContent) then
            Error('Failed to get data from JSONPlaceholder API.');

        Content := ResponseContent.Content;
        Content.ReadAs(ResponseString);

        JArray.ReadFrom(ResponseString);
        foreach JsonTokenType in JArray do begin
            JsonObject := JsonTokenType.AsObject();

            UserId := JsonObject.SelectToken('userId', ResultToken) ? ResultToken.AsValue().AsInteger() : 0;
            Id := JsonObject.SelectToken('id', ResultToken) ? ResultToken.AsValue().AsInteger() : 0;
            Title := JsonObject.SelectToken('title', ResultToken) ? ResultToken.AsValue().AsText() : '';
            Completed := JsonObject.SelectToken('completed', ResultToken) ? ResultToken.AsValue().AsBoolean() : false;

            AssignementMgt.InsertAssignment(UserId, Title, StrSubstNo('%1 created by %2, at %3', Title, UserId, Completed), Id, Completed);
        end;
    end;


    procedure POSTToDos()
    var
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        RequestHeaders: HttpHeaders;
        ContentHeaders: HttpHeaders;
        ResponseString: Text;
        JToken: JsonToken;
        PageToken: JsonToken;
    begin
        RequestMessage.SetRequestUri('https://jsonplaceholder.typicode.com/todos');
        Content := RequestMessage.Content;

        Content.WriteFrom('{"first": 1, "second": 2}');
        Content.GetHeaders(ContentHeaders);

        if ContentHeaders.Contains('Content-Type') then
            ContentHeaders.Remove('Content-Type');

        ContentHeaders.Add('Content-Type', 'application/json');

        RequestMessage.Content(Content);

        // RequestMessage.GetHeaders(RequestHeaders);
        // RequestHeaders.Add('Content-Type', 'application/json');

        if not Client.Send(RequestMessage, ResponseMessage) then
            Error('Something broke');


        Content := ResponseMessage.Content;
        Content.ReadAs(ResponseString);

        //     JToken.ReadFrom(ResponseString);
        //     if JToken.SelectToken('nextPage', PageToken) then
        //         RerunTheParseFunction();
    end;
}