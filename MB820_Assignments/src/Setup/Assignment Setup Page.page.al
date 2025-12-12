page 50202 "Assignment Setup Page"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Assignment Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = AssignmentSetup;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(AssignmentNumber; Rec.AssignmentNumber) { }
                field(AssignmentNumber2; Rec.AssignmentNumber2) { }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}