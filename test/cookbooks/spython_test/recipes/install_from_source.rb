package 'git-core'

update_version = node['spython_test']['update_version']
execute 'update-version' do
  action :nothing
  command "sed -i \"s/version=.*/version='#{update_version}',/\" setup.py"
  cwd node['spython_test']['path']
  not_if { update_version.nil? }
end

git node['spython_test']['path'] do
  action :sync
  repository node['spython_test']['repo']
  reference node['spython_test']['ref']
  notifies :run, 'execute[update-version]', :immediately
end

spython_exec 'install-from-source' do
  cwd node['spython_test']['path']
  command '-m pip install --upgrade .'
  runtime node['spython_test']['runtime'].to_s
end
