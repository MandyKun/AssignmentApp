codeunit 50200 AssignmentMgt
{
    trigger OnRun()
    begin

    end;


    procedure Complete(var Assignment: Record Assignment)
    begin
        Sleep(200);
        Assignment.Status := Assignment.Status::Completed;
        Assignment.Modify();
    end;


    procedure InProgress(var Assignment: Record Assignment)
    begin
        Sleep(200);
        Assignment.Status := Assignment.Status::"In Progress";
        Assignment.Modify();
    end;


    procedure InsertAssignment(UserId: Integer; Title: Text[100]; Description: Text)
    var
        Assignment: Record Assignment;
    begin
        Assignment.Init();
        Assignment.Validate("User ID", UserId);
        Assignment.Validate(Title, Title);
        Assignment.Validate(Description, CopyStr(Description, 1, MaxStrLen(Assignment.Description)));
        Assignment.Insert(true);
    end;


    procedure InsertAssignment(UserId: Integer; Title: Text[100]; Description: Text; APIID: Integer; Completed: Boolean)
    var
        Assignment: Record Assignment;
    begin
        Assignment.SetRange(APIID, APIID);
        if not Assignment.IsEmpty() then
            exit;

        Assignment.Init();
        Assignment.Validate("User ID", UserId);
        Assignment.Validate(Title, Title);
        Assignment.Validate(Description, CopyStr(Description, 1, MaxStrLen(Assignment.Description)));

        Assignment.Validate(APIID, APIID);
        if Completed then
            Assignment.Validate(Status, Assignment.Status::Completed)
        else
            Assignment.Validate(Status, Assignment.Status::Incomplete);
        Assignment.Insert(true);
    end;


    internal procedure ExportAssignmentsToAzure()
    var
        ExportAssignmentsToAzure: XmlPort "ExportAssignment";
        TEmpblob: Codeunit "Temp Blob";
        OStream: OutStream;
        IsStream: InStream;
        ExternalFileStorage: Codeunit "External File Storage";
    begin
        TEmpblob.CreateOutStream(OStream);
        ExportAssignmentsToAzure.SetDestination(OStream);
        ExportAssignmentsToAzure.Export();

        TEmpblob.CreateInStream(IsStream);
        ExternalFileStorage.Initialize(enum::"File Scenario"::Default);
        ExternalFileStorage.CreateFile('AssignmentsExport.csv', IsStream);
    end;


    procedure QueryReadFunction()
    var
        AssignmentQuery: Query AssignmentCustomerQuery;
        CustomerList: List of [Text];
        Assignment: Record Assignment;
        Customer: Record Customer;
    begin
        // if Assignment.FindSet() then
        //     repeat
        //         if Customer.Get(Assignment."Customer No") then
        //             if not CustomerList.Contains(AssignmentQuery.Name) then
        //                 CustomerList.Add(AssignmentQuery.Name);
        //     until Assignment.Next() = 0;


        if AssignmentQuery.Open() then
            while AssignmentQuery.Read() do begin
                if not CustomerList.Contains(AssignmentQuery.Name) then
                    CustomerList.Add(AssignmentQuery.Name);
            end;
    end;


    procedure VerifyAssignmentSetup()
    var
        AssignmentSetup: Record AssignmentSetup;
        NoSeries: Record "No. Series";
        NoSeriesErrorInfo: ErrorInfo;
    begin
        AssignmentSetup.Insert();
        if not NoSeries.Get(AssignmentSetup.AssignmentNumber) then begin
            NoSeriesErrorInfo.Title := 'Invalid No. Series';
            NoSeriesErrorInfo.Message := StrSubstNo('No. Series %1 in Assignment Setup is not valid.', AssignmentSetup.AssignmentNumber);
            NoSeriesErrorInfo.RecordId := AssignmentSetup.RecordId;

            NoSeriesErrorInfo.AddAction('Go to Assignment Setup', Codeunit::AssignmentErrorHandling, 'OpenAssignmentSetup');
            Error(NoSeriesErrorInfo);
        end
    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    // local procedure "Release Sales Document_OnAfterReleaseSalesDoc"(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    // begin
    //     InsertAssignment(0, StrSubstNo('Post Sales Doc %1', SalesHeader."No."), StrSubstNo('A sales order has been released %1 and %2', SalesHeader."Document Type", SalesHeader."No."));
    // end;
}