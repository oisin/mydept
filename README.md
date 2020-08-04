# mydept
Pull a CSV file of employee details from your BambooHR service, but only that part of the organization that you are managing.

Uses the `bamboozled` gem to communication with the BambooHR service. You will need to visit `My Devices & API Keys` when you log into BambooHR and create an API key.
Put this API key and the name of the `bamboohr.com` sub-domain allocated to your business into the client initialization call in the `mydept.rb` code.

This script also uses the `daru` gem to construct a dataframe and add a new column (monthly pay rate) before the result is serialized to a file. This is because dataframes are super useful.
