ActiveAdmin.register_page 'Setting' do
  title = 'Settings'
  menu label: title

  active_admin_settings_page(
    title: title
  )
end
