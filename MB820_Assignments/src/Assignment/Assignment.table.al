table 50200 Assignment
{
    Caption = 'Assignment';
    DataClassification = CustomerContent;
    DataCaptionFields = No, Title;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'Number';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            var
                AssignmentSetup: Record AssignmentSetup;
                NoSeries: Codeunit "No. Series";
            begin
                if No <> xRec.No then begin
                    AssignmentSetup.Get();
                    NoSeries.TestManual(AssignmentSetup.AssignmentNumber);
                    "No.Series" := ''
                end;
            end;
        }

        field(2; "User ID"; Integer)
        {
            Caption = 'User ID';
            DataClassification = EndUserPseudonymousIdentifiers;
        }

        field(3; Title; Text[100])
        {
            Caption = 'Assignment Date';
            DataClassification = CustomerContent;
        }

        field(4; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(5; "Customer No"; Code[20])
        {
            Caption = 'Customer No';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = Customer;
        }

        field(6; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            DataClassification = SystemMetadata;
        }

        field(7; Status; Enum "Assignment Status")
        {
            Caption = 'Status';
            DataClassification = SystemMetadata;
        }

        field(8; "No.Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(9; APIID; Integer)
        {
            Caption = 'API ID';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }

        key(StatusKey; Status)
        {
        }

        key(APIIDKey; APIID)
        {
            MaintainSiftIndex = false;
            MaintainSqlIndex = true;
        }
    }

    procedure AssistEdit() Result: Boolean
    var
        AssignmentSetup: Record AssignmentSetup;
        NoSeries: Codeunit "No. Series";
    begin
        AssignmentSetup.Reset();
        AssignmentSetup.Get();

        AssignmentSetup.Testfield(AssignmentNumber);
        if NoSeries.LookupRelatedNoSeries(AssignmentSetup.AssignmentNumber, xRec."No.Series", "No.Series") then begin
            No := NoSeries.GetNextNo("No.Series");
            exit(true);
        end;
    end;


    trigger OnInsert()
    var
        AssignmentSetup: Record AssignmentSetup;
        NoSeries: Codeunit "No. Series";
        Assignment: Record Assignment;
        AssignmentMgt: Codeunit AssignmentMgt;
    begin
        if No = '' then begin
            AssignmentSetup.Get();
            AssignmentSetup.TestField(AssignmentNumber);

            if NoSeries.AreRelated(AssignmentSetup.AssignmentNumber, xRec."No.Series") then
                "No.Series" := xRec."No.Series"
            else
                "No.Series" := AssignmentSetup.AssignmentNumber;
            No := NoSeries.GetNextNo("No.Series");

            Assignment.ReadIsolation(IsolationLevel::ReadUncommitted);
            Assignment.SetLoadFields(No);
            while Assignment.Get(No) do
                No := NoSeries.GetNextNo("No.Series");
        end;
    end;


    procedure SetCompleted()
    begin
        AssignmentMgt.Complete(Rec);
    end;


    procedure SetInProgress()
    begin
        AssignmentMgt.InProgress(Rec);
    end;

    var
        AssignmentMgt: Codeunit AssignmentMgt;
}