ActiveAdmin.register Order do
	# See permitted parameters documentation:
	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	#
	permit_params :name, :aasm_state

	#
	# or
	#
	# permit_params do
	#   permitted = [:permitted, :attributes]
	#   permitted << :other if params[:action] == 'create' && current_user.admin?
	#   permitted
	# end

  after_save do |order|
    event = params[:order][:active_admin_requested_event]
    unless event.blank?
      # whitelist to ensure we don't run an arbitrary method
      safe_event = (order.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
      raise "Forbidden event #{event} requested on instance #{order.id}" unless safe_event
      # launch the event with bang
      order.send("#{safe_event}!")
    end
  end

	index do
	  index_column
	  column :name
	  column :created_at
	  state_column("State", :aasm_state)
	  actions
	end

  form do |f|
  	f.inputs do
  		f.input :name
    	f.input :aasm_state, input_html: { disabled: true }, label: 'Current State'
    	f.input :active_admin_requested_event, label: 'Change State', collection: f.object.aasm.events(permitted: true).map(&:name)
  	end
  	f.actions
  end

end
