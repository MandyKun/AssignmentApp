page 50203 "Assignment RC"
{
    PageType = RoleCenter;
    Caption = 'Assignment RoleCenter';

    layout
    {
        area(RoleCenter)
        {
            part(RCHeadline; "Headline RC Business Manager")
            {
                ApplicationArea = All;
            }

            part(Control16; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
            }

            part(AssignmentAct; "Assignment Activities")
            {
                ApplicationArea = All;
            }
        }
    }
}