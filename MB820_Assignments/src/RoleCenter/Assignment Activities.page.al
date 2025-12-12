page 50204 "Assignment Activities"
{
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Assignment Act. Cue";

    layout
    {
        area(Content)
        {
            cuegroup(AssignmentCueGroup)
            {
                field("Incomplete Assignments"; Rec."Incomplete Assignments")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Assignment List";
                    ToolTip = 'Specifies the value of the Incomplete Assignments field.', Comment = '%';
                }

                field("In Progress Assignments"; Rec."In Progress Assignments")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Assignment List";
                    ToolTip = 'Specifies the value of the In Progress Assignments field.', Comment = '%';
                }

                field("Complete Assignments"; Rec."Complete Assignments")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Assignment List";
                    ToolTip = 'Specifies the value of the Complete Assignments field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
            Commit();
        end;
    end;
}