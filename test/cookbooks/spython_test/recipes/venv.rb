runtime = node['spython_test']['runtime'].to_s

spython_venv node['spython_test']['venv'] do
  runtime runtime
  user node['spython_test']['user']
  group node['spython_test']['group']
end

node['spython_test']['venv_packages'].each do |package, version|
  spython_package package do
    runtime runtime
    version version
    venv node['spython_test']['venv']
  end
end
