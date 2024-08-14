module ccr_tb_v;

// Parameters
parameter CLK_PERIOD = 10; // Clock period in ns

// Inputs
reg clk;
reg rst;
reg [7:0] customer_id_in;
reg [127:0] phone_number_in; // Increased width for string phone number
reg [127:0] address_in; // Increased width for string address
reg add_customer;
reg search_customer;

// Outputs
wire [7:0] found_customer_id;
wire [127:0] found_phone_number;
wire [127:0] found_address; // Increased width for string address

// Instantiate the module
customer_care_registry dut (
    .clk(clk),
    .rst(rst),
    .customer_id_in(customer_id_in),
    .phone_number_in(phone_number_in),
    .address_in(address_in),
    .add_customer(add_customer),
    .search_customer(search_customer),
    .found_customer_id(found_customer_id),
    .found_phone_number(found_phone_number),
    .found_address(found_address)
);

// Clock generation
always #5 clk = ~clk;

// Initial stimulus
initial begin
    clk = 0;
    rst = 1;
    add_customer = 0;
    search_customer = 0;
    customer_id_in = 8'h00;

    // Initialize phone number as string
    phone_number_in[127:0] = "00000000000000000000000000000000"; // 10-digit phone number string

    // Initialize address as string
    address_in[127:0] = "00000000000000000000000000000000"; // 32-character address string

    // Reset
    #10 rst = 0;

    // Rest of the test cases...

    // Test case 1: Search for a customer
    #20 search_customer = 1;
    #30; // Increased delay to 30 time units
    search_customer = 0;

    // Test case 2: Add a customer
    #30 add_customer = 1;
    customer_id_in = 8'h01;
    phone_number_in = "9137744281"; // Input phone number
    address_in = "Haneesh,Vandalur,Cresent"; // Longer address string
    #50; // Wait for the addition
    add_customer = 0;

    // Test case 3: Search for the newly added customer
    #30 search_customer = 1;
    #30; // Increased delay to 30 time units
    search_customer = 0;

    // Test case 4: Add multiple customers
    #30 add_customer = 1;
    customer_id_in = 8'h02;
    phone_number_in = "8056178703"; // Input phone number
    address_in = "	Potheri,SRMIST"; // Longer address string
    #50; // Wait for the addition
    add_customer = 0;

    // Test case 5: Search for one of the added customers
    #30 customer_id_in = 8'h02;
    search_customer = 1;
    #30; // Increased delay to 30 time units
    search_customer = 0;

    // Test case 6: Reset and search again
    #30 rst = 1;
    #10 rst = 0;
    #20 search_customer = 1;
    #30; // Increased delay to 30 time units
    search_customer = 0;

    // End simulation
    #100 $finish;
end
endmodule
