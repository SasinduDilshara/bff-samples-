import sample_microservices.customer_service as _;
import sample_microservices.order_service as _;

import ballerina/graphql;
import ballerina/http;

graphql:Client orderClient = check new ("http://localhost:9091/sales");
http:Client customerClient = check new ("http://localhost:9092");

type Customer record {|
    readonly string id;
    string email;
|};

type Order record {|
    readonly string id;
    string customerId;
    int quantity;
    string item;
|};

type OrderResponse record {|
    record {|Order[] orders;|} data;
|};

service /operations on new http:Listener(9090) {
    resource function get customers/[string email]/customerOrders() returns Order[]|http:InternalServerError {
        do {
            Customer customer = check customerClient->get(string `/crm/customers/${email}`);
            OrderResponse orderResponse = check orderClient->execute(string `{ orders { id quantity item customerId } }`);
            return from Order customerOrder in orderResponse.data.orders
                where customerOrder.customerId == customer.id
                select customerOrder;
        } on fail error e {
            return <http:InternalServerError>{
                body: e.detail().toString()
            };
        }
    }
}
