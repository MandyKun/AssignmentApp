codeunit 50205 AssignmentErrorHandling
{
    procedure OpenAssignmentSetup(NoSeriesErrorInfo: ErrorInfo)
    var
        AssignmentSetupPage: Page "Assignment Setup Page";
    begin
        AssignmentSetupPage.RunModal();
    end;
}