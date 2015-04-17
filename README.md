# Custom Attributes

This plugin allows custom attributes to be added to any model in a Rails application. Right now it's still work in progress.

## Installation
To use it in your project, add it to your Gemfile.
```ruby
gem 'custom_attributes', :git => 'git@github.com:7Vals/custom_attributes.git'
```

This is needed since the plugin is in a private repository for now. Then run bundle.
```shell
bundle
```

### Post Installation
Run the migrations.
```shell
rake custom_attributes:install:migrations
```

Review the generated migrations and then run the migration.
```shell
rake db:migrate
```

## Usage
Setup
```ruby
class Order < ActiveRecord::Base
	allows_custom_attributes
end
```

Custom attributes can be rendered using the `has_many` relation that is added to the model. E.g. in the `app/views/orders/_form.html.erb` file include
```ruby
<% form_for(@order) do |f| %>
...
<%= render @orders.custom_attributes, {form: f} %>
...
<% end %>
```

To render the custom attributes as editable pass the `editable: true` option. E.g.
```ruby
<% form_for(@order) do |f| %>
...
<%= render @orders.custom_attributes, {form: f, editable: true} %>
...
<% end %>
```

Once rendered the fields can be parsed using the following method. E.g. in `orders_controller.rb`.
```ruby
def create
	...
    @order.custom_attributes = params[:custom_attribute_value]
    ...
    @order.save
end
```

For now the Custom Attribute itself needs to be added maually to the `custom_attributes_custom_attributes` table. The fields in the table should be self explanatory.
