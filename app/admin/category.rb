ActiveAdmin.register Category do
  config.per_page=5

  scope 'High Level Groups', :high_level
  scope 'Child Categories', :leaves, :default => true

  filter :name
  filter :description

  index do
    column :photo do |t|
      image_tag t.photo.url(:thumb)
    end
    column :name
    column :parent do |c|
      Category.find(c.parent_id).name if c.parent_id.present?
    end
    column :description, :sortable => false
    default_actions
  end

  form do |f|
    f.inputs "Category Details" do
      f.input :parent, :collection => Category.where(:depth => 0)
      f.input :name
      f.input :photo,:as =>:file ,:hint => f.template.image_tag(f.object.photo.url(:thumb))
      f.input :description
    end
    f.buttons
  end

  show do
    attributes_table do
      row :name
      row :photo do |t|
        image_tag t.photo.url(:thumb)
      end
      row :description
      row :parent do |c|
        Category.find(c.parent_id).name if c.parent_id.present?
      end
      div do
        link_to "Back", admin_categories_path, :class => "button"
      end
    end
  end
end