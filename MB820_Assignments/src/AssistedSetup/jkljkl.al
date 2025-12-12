codeunit 50206 "AssignemtSetupWizard"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Guided Experience", 'OnRegisterAssistedSetup', '', false, false)]
    local procedure AddExtensionAssistedSetup_OnRegisterAssistedSetup()
    var
        GuidedExperience: Codeunit "Guided Experience";
        TitleLbl: Label 'Assited Setup Title';
        ShortTitleLbl: Label 'Assited Setup Short Title';
        DescriptionLbl: Label 'This assisted setup will help you to configure the Assignment Setup for your business needs. For more information, visit waldo.be.';
    begin
        GuidedExperience.InsertAssistedSetup(
            TitleLbl,
            ShortTitleLbl,
            DescriptionLbl,
            1,
            ObjectType::Page,
            GetPageId(),
            "Assisted Setup Group"::Extensions,
            '',
            "Video Category"::Uncategorized,
            '');

        UpdateStatus();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Guided Experience", 'OnReRunOfCompletedAssistedSetup', '', false, false)]
    local procedure OnReRunOfCompletedSetup(ExtensionID: Guid; ObjectType: ObjectType; ObjectID: Integer; var Handled: Boolean)
    var
        SetupAlreadyDoneQst: Label 'This setup is already done. Do you want to open the setup page instead?';
    begin
        if ExtensionID <> GetAppId() then exit;
        if ObjectType <> ObjectType::Page then exit;
        if ObjectID <> GetPageId() then exit;

        if Confirm(SetupAlreadyDoneQst, true) then
            Page.Run(GetPageId());

        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Guided Experience", 'OnAfterRunAssistedSetup', '', false, false)]
    local procedure OnAfterRunOfSetup(ExtensionID: Guid; ObjectType: ObjectType; ObjectID: Integer)
    begin
        if ExtensionID <> GetAppId() then exit;
        if ObjectID <> GetPageId() then exit;
    end;

    procedure UpdateStatus()
    var
        Rec: Record AssignmentSetup;
        GuidedExperience: Codeunit "Guided Experience";
    begin
        if not Rec.Get() then exit;

        if Rec.AssignmentNumber <> '' then
            GuidedExperience.CompleteAssistedSetup(ObjectType::Page, GetPageId());
    end;

    local procedure GetAppId(): Guid
    var
        EmptyGuid: Guid;
        Info: ModuleInfo;
    begin
        if Info.Id() = EmptyGuid then
            NavApp.GetCurrentModuleInfo(Info);
        exit(Info.Id());
    end;

    local procedure GetPageId(): Integer
    begin
        exit(Page::"Assignment Wizard");
    end;
}
