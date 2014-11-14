ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

   columns do
      column do
	  panel "Pending Requests" do
        panel "Places" do
          table do
            Place.find_all_by_status("Pending").map do |place|
              tr do
                td :width => "1px" do
                  li
                end
                td :width => "50px" do
                  link_to image_tag(place.featured_photo.url(:small_thumb)), edit_admin_place_path(place)
                end
                td link_to place.name, edit_admin_place_path(place)
              end
            end
          end
        end
		panel "events" do
          table do
            Event.find_all_by_status("Pending").map do |event|
              tr do
                td :width => "1px" do
                  li
                end
                td :width => "50px" do
                  link_to image_tag(event.featured_photo.url(:small_thumb)), edit_admin_event_path(event)
                end
                td link_to event.name, edit_admin_event_path(event)
              end
            end
          end
        end
      end
	  end

      column do
         panel "Top 5 Happening Places" do
            table do
              Place.find_all_by_status("Approved").last(5).map do |place|
                tr do
                   td :width => "1px" do
                     li
                   end
                   td :width => "50px" do
                     link_to image_tag(place.featured_photo.url(:small_thumb)), admin_place_path(place)
                   end
                   td link_to place.name, admin_place_path(place)
                 end
               end
             end
              div do
               link_to "View All Places", admin_places_path
              end
         end
      end
	  
	  column do
         panel "Top 5 Happening Events" do
            table do
              Event.find_all_by_status("Approved").last(5).map do |event|
                tr do
                   td :width => "1px" do
                     li
                   end
                   td :width => "50px" do
                     link_to image_tag(event.featured_photo.url(:small_thumb)), admin_event_path(event)
                   end
                   td link_to event.name, admin_event_path(event)
                 end
               end
             end
              div do
               link_to "View All Events", admin_events_path
              end
         end
      end

      column do
        panel "Registered Users" do
          User.last(10).map do |user|
            li link_to user.firstname, admin_user_path(user)
          end
          div do
            br link_to "View All Users", admin_users_path
          end
        end
      end
    end
  end
end
