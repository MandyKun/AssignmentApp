table 50202 "Assignment Act. Cue"
{
    Caption = 'Assignment Activities Cue';
    ReplicateData = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }

        field(24; "Incomplete Assignments"; Integer)
        {
            CalcFormula = count(Assignment where(Status = filter(Incomplete)));
            Caption = 'Incomplete Assignments';
            FieldClass = FlowField;
        }

        field(25; "In Progress Assignments"; Integer)
        {
            CalcFormula = count(Assignment where(Status = filter("In Progress")));
            Caption = 'In Progress Assignments';
            FieldClass = FlowField;
        }

        field(26; "Complete Assignments"; Integer)
        {
            CalcFormula = count(Assignment where(Status = filter(Completed)));
            Caption = 'Complete Assignments';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}