codeunit 50203 CustomEdOcImpl implements "E-Document"
{
    var
        EDocumentServiceRec: Codeunit "EDoc PEPPOL BIS 3.0";

    procedure Check(var SourceDocumentHeader: RecordRef; EDocumentService: Record "E-Document Service"; EDocumentProcessingPhase: Enum "E-Document Processing Phase")
    var
        SalesHeader: Record "Sales Header";
    begin
        case SourceDocumentHeader.Number of
            Database::"Sales Header":
                begin
                    SourceDocumentHeader.SetTable(SalesHeader);
                    SalesHeader.TestField("Your Reference");
                end;
        end;

        EDocumentServiceRec.Check(SourceDocumentHeader, EDocumentService, EDocumentProcessingPhase);
    end;

    procedure Create(EDocumentService: Record "E-Document Service"; var EDocument: Record "E-Document"; var SourceDocumentHeader: RecordRef; var SourceDocumentLines: RecordRef; var TempBlob: Codeunit "Temp Blob")
    begin
        EDocumentServiceRec.Create(EDocumentService, EDocument, SourceDocumentHeader, SourceDocumentLines, TempBlob);
    end;

    procedure CreateBatch(EDocumentService: Record "E-Document Service"; var EDocuments: Record "E-Document"; var SourceDocumentHeaders: RecordRef; var SourceDocumentsLines: RecordRef; var TempBlob: Codeunit "Temp Blob")
    begin
        EDocumentServiceRec.CreateBatch(EDocumentService, EDocuments, SourceDocumentHeaders, SourceDocumentsLines, TempBlob);
    end;

    procedure GetBasicInfoFromReceivedDocument(var EDocument: Record "E-Document"; var TempBlob: Codeunit "Temp Blob")
    begin
        EDocumentServiceRec.GetBasicInfoFromReceivedDocument(EDocument, TempBlob);
    end;

    procedure GetCompleteInfoFromReceivedDocument(var EDocument: Record "E-Document"; var CreatedDocumentHeader: RecordRef; var CreatedDocumentLines: RecordRef; var TempBlob: Codeunit "Temp Blob")
    begin
        EDocumentServiceRec.GetCompleteInfoFromReceivedDocument(EDocument, CreatedDocumentHeader, CreatedDocumentLines, TempBlob);
    end;
}