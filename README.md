# Custom Attributes
This plugin allows custom attributes to be added to any model in a Rails application. The main work is done in a generator which generates the relevant code (models, views, concerns etc) for a model passed as the first argument. It supports multi-tenant applications; the `--tenant` (optional) argument can be passed to the generator to define the column to use as tenant.

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
First we need to use the generator to install the code for the relevant model. So assuming the model you want to allow custom attributes for is called `Order`, then use the following command.
```shell
rails generate custom_attributes:initialize Order
```
If you have a multi-tenant application with say the `Company` model acting as the tenant run the following instead.
```shell
rails generate custom_attributes:initialize Order --tenant=company
```
Now review the generated migrations and then run the migration.
```shell
rake db:migrate
```

## Usage
Custom attributes can be rendered using the `has_many` relation that is added to the model. E.g. in the `app/views/orders/_form.html.erb` file include
```ruby
<% form_for(@order) do |f| %>
...
<%= render @orders.custom_attributes %>
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
The fields that are rendered can be parsed using the `custom_attributes=(...)` method in the generated `OrderCustomAttributes` concern. If you are using `params.require(...)` to whitelist certain parameters, you will need to whitelist the custom_attributes in the appropriate controller. E.g. in `order_controller.rb`

**Note**: With the inline editing feature this should not be needed.
```ruby
def order_params
    params.require(:asset).permit(:name, :location).tap do |w|
        w[:custom_attributes] = params[:asset][:custom_attributes]
    end
end
```
