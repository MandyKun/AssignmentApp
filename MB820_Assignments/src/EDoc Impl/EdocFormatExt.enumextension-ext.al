enumextension 50200 EdocFormatExt extends "E-Document Format"
{
    value(50200; CustomFormat)
    {
        Caption = 'Custom E-Document Format';
        Implementation = Microsoft.eServices.EDocument."E-Document" = CustomEdOcImpl;
    }
}