# Zendesk Sell

**Zendesk Sell** is a Ruby client for the [Zendesk Sell (Sales CRM) API](https://developer.zendesk.com/api-reference/sales-crm/resources/introduction/). This gem provides a robust and modular interface to interact with Zendesk Sell’s resources—such as leads, deals, contacts, companies, tasks, and users—using Faraday for HTTP requests.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zendesk_sell'
```

Then execute:

```bash
bundle install
```

Or install it yourself via:

```bash
gem install zendesk_sell
```

## Configuration

The client uses the SELL_ACCESS_TOKEN environment variable by default. You can also pass the token directly when initializing the client.

**Using an Environment Variable**

Set your token in your shell or Rails application configuration:

```bash
export SELL_ACCESS_TOKEN="your_actual_sell_access_token"
```

## Direct Initialization

```ruby
client = ZendeskSell::Client.new(access_token: 'your_actual_sell_access_token')
```

## Available Endpoints

The `zendesk_sell` gem supports the following API endpoints:

- **Leads:** Manage potential customers and track leads.
- **Deals:** Create, update, and manage business opportunities.
- **Contacts:** Access and manage contact information for individuals.
- **Companies:** Organize and maintain details about companies or organizations.
- **Tasks:** Manage tasks and activities related to your sales process.
- **Users:** Retrieve and manage information about users in your Zendesk Sell account.

## Direct Initialization

Below are several examples demonstrating how to use the client with various Zendesk Sell resources.

### 1. Listing Resources

**List All Leads**

```ruby
client = ZendeskSell::Client.new
leads = client.leads.list(page: 1, per_page: 20)
puts leads
```

***List All Deals***

```ruby
deals = client.deals.list(page: 1, per_page: 20)
puts deals
```

### 2. Retrieving a Single Resource

**Retrieve a Specific Lead**

```ruby
lead_id = 123
lead = client.leads.find(lead_id)
puts "Lead Details: #{lead}"
```

**Retrieve a Specific Contact**

```ruby
contact_id = 456
contact = client.contacts.find(contact_id)
puts "Contact Details: #{contact}"
```

### 3. Creating a New Resource

**Create a New Lead**

```ruby
new_lead_attributes = {
  name: "John Doe",
  email: "john.doe@example.com",
  phone: "+123456789"
}
created_lead = client.leads.create(new_lead_attributes)
puts "Created Lead: #{created_lead}"
```

**Create a New Deal**

```ruby
new_deal_attributes = {
  title: "New Business Opportunity",
  value: 5000,
  currency: "USD"
}
created_deal = client.deals.create(new_deal_attributes)
puts "Created Deal: #{created_deal}"
```

### 4. Updating a Resource

**Update an Existing Lead**

```ruby
lead_id = 123
updated_attributes = { name: "Jane Doe", phone: "+1987654321" }
updated_lead = client.leads.update(lead_id, updated_attributes)
puts "Updated Lead: #{updated_lead}"
```

**Update a Company**

```ruby
company_id = 789
updated_company_attributes = { name: "Acme Corp", industry: "Technology" }
updated_company = client.companies.update(company_id, updated_company_attributes)
puts "Updated Company: #{updated_company}"
```

### 5. Deleting a Resource

**Delete a Lead**

```ruby
lead_id = 123
client.leads.delete(lead_id)
```

**Delete a Deal**

```ruby
deal_id = 456
client.deals.delete(deal_id)
```

### 6. Error Handling


```ruby
begin
  lead = client.leads.find(9999)  # Assuming 9999 is an invalid ID
rescue ZendeskSell::Errors::ApiError => e
  puts "API Error: #{e.message}"
rescue ZendeskSell::Errors::ConnectionError => e
  puts "Connection Error: #{e.message}"
end
```

### 7. Search 

```ruby
results = client.leads.search(
  {
    "filter" => {
      "filter" => {
        "attribute" => { "name" => "email" },
        "parameter" => { "eq" => "john.doe@example.com" }
      }
    },
    "projection" => [
      { "name" => "id" },
      { "name" => "name" },
      { "name" => "email" }
    ]
  }
)
```

### 8. Testing

```ruby
bundle exec rspec
```


### Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/RTJ/zendesk_sell>.

License

This gem is available as open source under the terms of the MIT License.
