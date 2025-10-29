# app/blueprints/post_blueprint.rb
class UserBlueprint < Blueprinter::Base
  identifier :id

  view :normal do # Basic view for an index page
    fields :name, :email
  end

  view :extended do # Detailed view for a show page
    include_view :normal # Include all fields from the :normal view
    fields :password_digest
    # Include an association using another blueprint
    # association :is_admin, blueprint: UserBlueprint 
  end
end