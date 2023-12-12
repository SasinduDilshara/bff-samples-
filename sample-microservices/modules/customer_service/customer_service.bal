import ballerina/http;

type Customer record {|
    readonly string id;
    string email;
|};

table<Customer> key(id) customers = table [
    {id: "C-123", email: "John@abc.com"},
    {id: "C-223", email: "Jane@abc.com"},
    {id: "C-173", email: "Joe@abc.com"}
];

service /crm on new http:Listener(9092) {
    resource function get customers/[string email]() returns Customer|http:NotFound {
        foreach Customer customer in customers {
            if customer.email == email {
                return customer;
            }
        }
        return http:NOT_FOUND;
    }
}
