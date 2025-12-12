namespace AssignmemtPermissions;

permissionset 50200 AssignmentAdmin
{
    Assignable = true;
    Permissions = tabledata Assignment = RIMD,
        tabledata "Assignment Act. Cue" = RIMD,
        tabledata AssignmentSetup = RIMD,
        table Assignment = X,
        table "Assignment Act. Cue" = X,
        table AssignmentSetup = X,
        page "Assigment Card" = X,
        page "Assignment Activities" = X,
        page "Assignment List" = X,
        page "Assignment RC" = X,
        page "Assignment Setup Page" = X,
        report PrintAssignment = X,
        codeunit AssignmentMgt = X,
        codeunit Install = X,
        codeunit Upgrade = X,
        xmlport ExportAssignment = X,
        query AssignmentCustomerQuery = X;
}