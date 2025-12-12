query 50200 AssignmentCustomerQuery
{
    QueryType = Normal;

    elements
    {
        dataitem(Assignment; Assignment)
        {
            column(No; No)
            {
            }
            column(Title; Title)
            {
            }
            column("UserID"; "User ID")
            {
            }
            column("CategoryCode"; "Category Code")
            {
            }
            column(Status; Status)
            {
            }

            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = Assignment."Customer No";
                SqlJoinType = LeftOuterJoin;

                column(Name; Name)
                {

                }
            }
        }
    }
}