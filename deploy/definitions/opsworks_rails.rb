define :opsworks_rails do
  deploy = params[:deploy_data]
  application = params[:app]

  include_recipe node[:opsworks][:rails_stack][:recipe]

  # write out memcached.yml
  template "#{deploy[:deploy_to]}/shared/config/memcached.yml" do
    cookbook "rails"
    source "memcached.yml.erb"
    mode "0660"
    owner deploy[:user]
    group deploy[:group]
    variables(:memcached => (deploy[:memcached] || {}), :environment => deploy[:rails_env])

    only_if do
      deploy[:memcached][:host].present?
    end
  end

  # write out application.yml
  template "#{deploy[:deploy_to]}/shared/config/application.yml" do
    cookbook "rails"
    source "application.yml.erb"
    mode "0600"
    owner deploy[:user]
    group deploy[:group]
    variables(:config => deploy[:config])

    only_if do
      deploy[:config].present?
    end
  end

  # write out newrelic.yml
  template "#{deploy[:deploy_to]}/shared/config/newrelic.yml" do
    cookbook "rails"
    source "newrelic.yml.erb"
    mode "0600"
    owner deploy[:user]
    group deploy[:group]
    variables(:config => deploy[:newrelic])

    only_if do
      deploy[:newrelic].present?
    end
  end

  execute "symlinking subdir mount if necessary" do
    command "rm -f /var/www/#{deploy[:mounted_at]}; ln -s #{deploy[:deploy_to]}/current/public /var/www/#{deploy[:mounted_at]}"
    action :run
    only_if do
      deploy[:mounted_at] && File.exists?("/var/www")
    end
  end

end
