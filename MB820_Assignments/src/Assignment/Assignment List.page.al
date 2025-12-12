page 50200 "Assignment List"
{
    Caption = 'Assignments';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Assignment;

    CardPageId = "Assigment Card";
    Editable = false;

    QueryCategory = 'Assignment List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the Number field.', Comment = '%';
                }

                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Assignment Date field.', Comment = '%';
                }

                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }

                field("Category Code"; Rec."Category Code")
                {
                    ToolTip = 'Specifies the value of the Category Code field.', Comment = '%';
                }

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
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

            action(GetTodos)
            {
                Caption = 'Get To-Dos from API';
                ApplicationArea = All;
                Image = Refresh;

                trigger OnAction()
                var
                    JsonPlaceholderMgt: Codeunit JsonPlaceholderMgt;
                begin
                    JsonPlaceholderMgt.GetToDos();
                end;
            }
        }

        area(Reporting)
        {
            // action(ExportAssignments)
            // {
            //     Caption = 'Export Assignments';
            //     Image = ExportFile;
            //     ApplicationArea = All;

            //     RunObject = XmlPort "ExportAssignment";
            // }


            action(ExportAssignments)
            {
                Caption = 'Export Assignments';
                Image = ExportFile;
                ApplicationArea = All;

                trigger OnAction()
                var
                    AssignmentMgt: Codeunit AssignmentMgt;
                begin
                    AssignmentMgt.ExportAssignmentsToAzure();
                end;
            }

            action(PrintAssignments)
            {
                Caption = 'Print Assignments';
                Image = Print;
                ApplicationArea = All;

                RunObject = Report PrintAssignment;
            }
        }
    }
}