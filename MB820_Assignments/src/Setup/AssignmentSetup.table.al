table 50201 AssignmentSetup
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            DataClassification = SystemMetadata;
        }

        field(2; AssignmentNumber; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }

        field(3; AssignmentNumber2; Code[20])
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; PrimaryKey)
        {
            Clustered = true;
        }
    }
}