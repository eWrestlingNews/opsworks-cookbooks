service "varnish" do
  supports :status => true, :restart => true, :reload => true
  action :nothing
end

template "/etc/varnish/default.vcl" do
  source "default.vcl.erb"
  owner "root"
  group "root"
  mode 0660
  notifies :reload, 'service[varnish]', :immediately
end

service "varnish" do
  action [ :enable, :start ]
end
