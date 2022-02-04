runtime = node['spython_test']['runtime'].to_s

spython_venv node['spython_test']['venv'] do
  runtime runtime
  user node['spython_test']['user']
  group node['spython_test']['group']
end

node['spython_test']['venv_packages'].each do |package, version|
  spython_package "venv-#{package}" do
    action :install
    name package
    runtime runtime
    version version.to_s unless version.nil?
    venv node['spython_test']['venv']
  end
end
