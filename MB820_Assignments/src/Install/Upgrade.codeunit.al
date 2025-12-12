codeunit 50202 Upgrade
{
    Subtype = Upgrade;


    trigger OnUpgradePerCompany()
    var
        AssignmentSetup: Record AssignmentSetup;
    begin
        UpgradeFeatureName()
    end;

    #region UpgradeFeatureName
    internal procedure UpgradeFeatureName()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
        AssignmentSetup: Record AssignmentSetup;
    begin
        if UpgradeTag.HasUpgradeTag(ReturnFeatureNameUpgradeTag()) then
            exit;

        if not AssignmentSetup.Get() then begin
            AssignmentSetup.Init();
            AssignmentSetup.Insert();
        end;

        AssignmentSetup.AssignmentNumber2 := AssignmentSetup.AssignmentNumber;
        AssignmentSetup.Modify(true);

        UpgradeTag.SetUpgradeTag(ReturnFeatureNameUpgradeTag());
    end;


    #region ReturnFeatureNameUpgradeTag
    internal procedure ReturnFeatureNameUpgradeTag(): Text[250]
    begin
        exit('Prefix-ID-FeatureName-20251210');
    end;
    #endregion ReturnFeatureNameUpgradeTag   
    #endregion UpgradeFeatureName
}