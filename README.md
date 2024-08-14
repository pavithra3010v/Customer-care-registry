	When a request to add a new customer is received (‘add_customer’ signal asserted), the module checks if there is available space within the registry (limited by the ‘MAX_CUSTOMERS’ parameter). 
If there is space, the provided customer ID, phone number, and address are stored in the respective arrays, incrementing the count of registered customers (‘num_customers’). This ensures that new customer information is appropriately integrated into the registry.

	For searching existing customers, the module waits for a signal indicating a search request (search_customer signal asserted) along with the customer ID to search for (customer_id_in).
Upon receiving this request, the module iterates through the array of customer IDs, comparing each entry with the provided ID. If a match is found, the corresponding phone number and address are retrieved from their respective arrays and returned as outputs (found_customer_id, found_phone_number, found_address). This iterative search process allows for efficient retrieval of customer information based on their unique identifier.

	Additionally, the module includes reset functionality triggered by a reset signal (rst asserted). This feature initializes all internal registers, clearing any existing customer data and resetting the count of registered customers,
ensuring a clean start or system recovery when necessary.
