xmlport 50200 ExportAssignment
{
    Format = VariableText;
    //FieldSeparator = 
    Direction = Export;

    schema
    {
        textelement(Root)
        {
            tableelement(Assignment; Assignment)
            {
                fieldattribute(AssignmentNo; Assignment.No)
                {
                }

                fieldattribute(Title; Assignment.Title)
                {
                }

                fieldelement(UserID; Assignment."User ID")
                {
                }

                fieldelement(CategoryCode; Assignment."Category Code")
                {
                }

                fieldelement(Status; Assignment.Status)
                {
                }
            }
        }
    }
}