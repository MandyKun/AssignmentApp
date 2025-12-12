page 50201 "Assigment Card"
{
    PageType = Card;
    SourceTable = Assignment;

    Caption = 'Assignment Card';
    RefreshOnActivate = true;

    AboutTitle = 'Assignment Card';
    AboutText = 'This page displays details of a single *assignment*.';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the Number field.', Comment = '%';
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();
                    end;
                }

                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Assignment Date field.', Comment = '%';
                    ApplicationArea = All;

                    AboutTitle = 'Title';
                    AboutText = 'The title of the assignment.';
                }

                field("Category Code"; Rec."Category Code")
                {
                    ToolTip = 'Specifies the value of the Category Code field.', Comment = '%';
                    ApplicationArea = All;
                }

                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                    ApplicationArea = All;

                    AboutTitle = 'User ID';
                    AboutText = 'The identifier of the user associated with the assignment.';
                }

                field("Customer No"; Rec."Customer No")
                {
                    ToolTip = 'Specifies the value of the Customer No field.', Comment = '%';
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    ApplicationArea = All;

                    AboutTitle = 'Status';
                    AboutText = 'The current status of the assignment.';
                }
            }

            group(SystemInfo)
            {

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                    ApplicationArea = All;
                }

                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                    ApplicationArea = All;
                }

                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    ApplicationArea = All;
                }

                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                    ApplicationArea = All;
                }

                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Complete)
            {
                Caption = 'Complete Assignment';
                ApplicationArea = All;
                Image = Approval;

                trigger OnAction()
                begin
                    Rec.SetCompleted();
                end;
            }

            action(InProgress)
            {
                Caption = 'Set In Progress';
                ApplicationArea = All;
                Image = WorkCenterLoad;

                trigger OnAction()
                begin
                    Rec.SetInProgress();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        AssignmentMgt: Codeunit AssignmentMgt;
    begin
        AssignmentMgt.VerifyAssignmentSetup();
    end;
}