// Perform the following on load:
    // Show the user that the data is loading
    // In the background, for each desired search,
        // Get the source code(s) resulting from performing this particular search on Apartments.com.
        // Synchronously, for each result,
            // Pull the table containing data from the source code.
            // For each row in the table,
                // Add a property indicating whether or not the result contains bike storage.
                // Add a property containing the address of the apartment complex.
                // Store the result based on some identifying criterion, such as apartment name.
    // Once all searches have resolved, proceed to data extraction:
    // For each data element,
        // Get the GPS coordinates of the address and save them as a property.
        // Identify the price of each element.
        // Identify the floor area of each element.
    // Once data parsing has resolved, proceed to analysis:
        // Compute, with 95% confidence, the increase in apartment value based on whether or not bike storage is present.

    // Halt the "loading" message
    // Show the results