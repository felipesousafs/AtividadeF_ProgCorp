json.extract! expense, :id, :apartment_id, :description, :is_fixed_value, :value, :month_of_ref, :created_at, :updated_at
json.url expense_url(expense, format: :json)
