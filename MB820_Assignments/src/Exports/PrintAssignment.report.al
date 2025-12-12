report 50200 PrintAssignment
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = WordLayout;

    dataset
    {
        dataitem(Assignment; Assignment)
        {
            column(No_Assignment; No)
            {
            }
            column(Status_Assignment; Status)
            {
            }
            column(Title_Assignment; Title)
            {
            }
            column(UserID_Assignment; "User ID")
            {
            }
            column(CategoryCode_Assignment; "Category Code")
            {
            }

            trigger OnPreDataItem()
            begin
                Assignment.SetRange(Status, StatusFilterVar);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

                field(FilterStatus; StatusFilterVar)
                {
                    Caption = 'Status Filter';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    rendering
    {
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = './src/Exports/Layouts/PrintAssignment.docx';
        }
    }

    var
        StatusFilterVar: Enum "Assignment Status";

}