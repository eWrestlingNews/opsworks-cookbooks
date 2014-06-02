include_recipe 'rails::configure'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  # write out application.yml
  template "#{deploy[:deploy_to]}/shared/config/application.yml" do
    cookbook "rails"
    source "application.yml.erb"
    mode "0600"
    owner deploy[:user]
    group deploy[:group]
    variables(:config => deploy[:config])
    notifies :run, "execute[restart Rails app #{application}]"

    only_if do
      deploy[:config].present? && File.directory?("#{deploy[:deploy_to]}/shared/config/")
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
    notifies :run, "execute[restart Rails app #{application}]"

    only_if do
      deploy[:newrelic].present? && File.directory?("#{deploy[:deploy_to]}/shared/config/")
    end
  end
end
