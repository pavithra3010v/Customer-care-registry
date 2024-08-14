module customer_care_registry(
    input  clk,
    input  rst,
    input  [7:0] customer_id_in,
    input  [127:0] phone_number_in,
    input  [127:0] address_in,
    input  add_customer,
    input  search_customer,
    output reg [7:0] found_customer_id,
    output reg [127:0] found_phone_number,
    output reg [127:0] found_address
);

// Parameter definitions
parameter MAX_CUSTOMERS = 10;        // Maximum number of customers
parameter CUSTOMER_ID_WIDTH = 8;     // Width of customer ID
parameter PHONE_NUMBER_WIDTH = 128;   // Width of phone number
parameter ADDRESS_WIDTH = 128;       // Width of address

// Internal registers
reg [7:0] customer_ids [0:MAX_CUSTOMERS-1];       // Array to store customer IDs
reg [127:0] phone_numbers [0:MAX_CUSTOMERS-1];    // Array to store phone numbers
reg [127:0] addresses [0:MAX_CUSTOMERS-1];        // Array to store addresses
reg [3:0] num_customers = 0;  
integer i;                    // Number of customers in the registry

// Search customer logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        found_customer_id <= 0;
        found_phone_number <= 0;
        found_address <= 0;
    end else begin
        // Search for the customer based on customer ID
        for (i = 0; i < MAX_CUSTOMERS; i = i + 1) begin
            if (customer_ids[i] == customer_id_in) begin
                found_customer_id <= customer_ids[i];
                found_phone_number <= phone_numbers[i];
                found_address <= addresses[i];
                // Exit loop once customer is found
           
            end
        end
    end
end

// Add customer logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset all registers
        for (i = 0; i < MAX_CUSTOMERS; i = i + 1) begin
            customer_ids[i] <= 8'h00;
            phone_numbers[i] <= 128'h00000000000000000000000000000000;
            addresses[i] <= 128'h00000000000000000000000000000000;
        end
        num_customers <= 0;
    end else begin
        if (add_customer && num_customers < MAX_CUSTOMERS) begin
            // Add customer
            customer_ids[num_customers] <= customer_id_in;
            phone_numbers[num_customers] <= phone_number_in;
            addresses[num_customers] <= address_in;
            num_customers <= num_customers + 1;
        end
    end
end

endmodule
