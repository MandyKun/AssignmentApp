codeunit 50201 Install
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        AssignmentSetup: Record AssignmentSetup;
    begin
        if not AssignmentSetup.Get() then begin
            AssignmentSetup.Init();
            AssignmentSetup.Insert();
        end;
    end;
}