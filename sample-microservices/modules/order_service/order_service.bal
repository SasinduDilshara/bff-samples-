import ballerina/graphql;

type Order record {|
    readonly string id;
    string customerId;
    ShippingAddress shippingAddress;
    int quantity;
    string item;
|};

type ShippingAddress record {|
    string street;
    string city;
|};

table<Order> key(id) orders = table [
    {id: "HM-123", customerId: "C-123", quantity: 3, item: "Iphone 14", shippingAddress: {street: "Main St", city: "New York"}},
    {id: "HM-251", customerId: "C-223", quantity: 4, item: "TV", shippingAddress: {street: "Main St", city: "Rome"}},
    {id: "HM-850", customerId: "C-123", quantity: 6, item: "Iphone 12", shippingAddress: {street: "Main St", city: "New York"}}
];

service /sales on new graphql:Listener(9091) {
    resource function get orders() returns Order[] {
        return orders.toArray();
    }
}
